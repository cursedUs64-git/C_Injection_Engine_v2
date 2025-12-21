# ==========================
# C Injection Engine v2
# ==========================

include util.mk

# ----------------------------
# Paths / tools
# ----------------------------
SRC_ROOT_DIR    := src
OBJ_ROOT_DIR    := obj
OBJ_CUSTOM_DIR  := obj/custom
TMP_DIR         := tmp
TOOLS_DIR       := tools
SM64TOOLS_DIR   := $(TOOLS_DIR)/sm64tools
RECOMP_CC_DIR   := $(TOOLS_DIR)/ido-static-recomp
LD_SCRIPT       := ld/link.ld

MINIFIND        := $(TOOLS_DIR)/minifind
GEN_ARMIPS_SYMS := $(TOOLS_DIR)/gen_armips_syms
CC              := $(RECOMP_CC_DIR)/build/out/cc
CC_CHECK        := gcc
LD              := mips64-elf-ld
AS              := mips64-elf-as
OBJDUMP         := mips64-elf-objdump
OBJCOPY         := mips64-elf-objcopy
ARMIPS          := $(TOOLS_DIR)/armips # not using system-wide armips anymore cus uh no
N64CKSUM        := $(SM64TOOLS_DIR)/n64cksum

ROM_IN          := baserom.us.z64
ROM_OUT         := patched.us.z64

INJECT_OBJ      := $(TMP_DIR)/injection_custom.o
INJECT_BIN      := $(TMP_DIR)/injection_custom.bin
CUSTOM_MAP      := $(TMP_DIR)/injection_custom.map
SYMBOLS_INC     := $(TMP_DIR)/inject_symbols.inc.asm

# ----------------------------
# Auto-discover headers and sources
# ----------------------------
HEADER_DIRS := $(shell $(MINIFIND) $(SRC_ROOT_DIR) -type f -name "*.h" 2>/dev/null | xargs -r -n1 dirname | sort -u)
ifeq ($(strip $(HEADER_DIRS)),)
  HEADER_DIRS := $(SRC_ROOT_DIR)
endif
INCLUDE_FLAGS := -Iinclude -Iinclude/sm64 -Iinclude/sm64/libc $(foreach d,$(HEADER_DIRS),-I$(d))

CUSTOM_C_SRCS   := $(shell $(MINIFIND) $(SRC_ROOT_DIR) -type f -name "*.c" 2>/dev/null)
CUSTOM_ASM_SRCS := $(shell $(MINIFIND) $(SRC_ROOT_DIR) -type f \( -name "*.s" -o -name "*.S" -o -name "*.asm" \) 2>/dev/null)

CUSTOM_OBJS := $(patsubst $(SRC_ROOT_DIR)/%.c,$(OBJ_ROOT_DIR)/%.o,$(CUSTOM_C_SRCS)) \
               $(patsubst $(SRC_ROOT_DIR)/%.s,$(OBJ_ROOT_DIR)/%.o,$(CUSTOM_ASM_SRCS)) \
               $(patsubst $(SRC_ROOT_DIR)/%.S,$(OBJ_ROOT_DIR)/%.o,$(CUSTOM_ASM_SRCS)) \
               $(patsubst $(SRC_ROOT_DIR)/%.asm,$(OBJ_ROOT_DIR)/%.o,$(CUSTOM_ASM_SRCS))

OBJ_DIRS := $(sort $(dir $(CUSTOM_OBJS)))

# ----------------------------
# PNG → .inc.c conversion (auto)
# ----------------------------
N64GRAPHICS := $(SM64TOOLS_DIR)/n64graphics

# Find all PNG files under src/
PNG_SRCS := $(shell $(MINIFIND) $(SRC_ROOT_DIR) -type f -name "*.png" 2>/dev/null)
INC_C_SRCS := $(patsubst %.png,%.inc.c,$(PNG_SRCS))

# Conversion rule
%.inc.c: %.png $(N64GRAPHICS)
	@echo "Converting: $< -> $@"
	@$(N64GRAPHICS) -s u8 -i $@ -g $< -f $(lastword $(subst ., ,$(basename $<)))

# ----------------------------
# Flags
# ----------------------------
CFLAGS := $(INCLUDE_FLAGS) -O2 -G0 -Wo,-loopunroll,0 -non_shared -Wab,-r4300_mul -Xcpluscomm -Xfullwarn -signed -32 -nostdinc -DTARGET_N64 -D_LANGUAGE_C -mips2 
ASFLAGS := -march=vr4300 -mabi=32
CC_CHECK_CFLAGS := -fsyntax-only -fsigned-char -std=gnu90 -Wall -Wextra -Wno-format-security -Wno-main -DNON_MATCHING -DAVOID_UB $(INCLUDE_FLAGS)

# ----------------------------
# Phony targets
# ----------------------------
.PHONY: all build tools obj_dirs inject print_map gen_symbols clean distclean info

# ----------------------------
# Default target
# ----------------------------
all: build
	@echo "Build complete. Run 'make inject' to patch the ROM."

# ----------------------------
# Info
# ----------------------------
info:
	@echo "Found sources under src/:"
	@echo "  C files:   $(words $(CUSTOM_C_SRCS))"
	@echo "  ASM files: $(words $(CUSTOM_ASM_SRCS))"
	@echo "  Object dirs: $(words $(OBJ_DIRS))"

# ----------------------------
# Build target
# ----------------------------
build: tools info obj_dirs $(INC_C_SRCS) $(CUSTOM_OBJS) $(INJECT_OBJ)
	@rm -f a.out
	@echo "Build finished successfully."

# ----------------------------
# Tools
# ----------------------------
tools:
	@echo "Building tools..."
	@$(MAKE) -C $(TOOLS_DIR) all
	@$(MAKE) -C $(SM64TOOLS_DIR)

$(MINIFIND): $(TOOLS_DIR)/util/minifind.c
	@mkdir -p $(dir $(MINIFIND))
	@gcc -o $(MINIFIND) $(TOOLS_DIR)/util/minifind.c

$(GEN_ARMIPS_SYMS): $(TOOLS_DIR)/util/gen_armips_syms.c # thisa tool is unused for now, intended for generating asm files from MAP files from decomp. dma_read to be non-static
	@mkdir -p $(dir $(MINIFIND))
	@gcc -o $(MINIFIND) $(TOOLS_DIR)/util/gen_armips_syms.c

# ----------------------------
# Ensure directories exist
# ----------------------------
obj_dirs:
	@echo "Creating object directories..."
	@for d in $(OBJ_DIRS) $(TMP_DIR); do mkdir -p $$d; done

# ----------------------------
# Compile C files
# ----------------------------
$(OBJ_ROOT_DIR)/%.o: $(SRC_ROOT_DIR)/%.c | obj_dirs tools
	@echo "CC $< -> $@"
	@$(CC_CHECK) $(CC_CHECK_CFLAGS) -MMD -MP -MT $@ -MF $(OBJ_ROOT_DIR)/$*.d $< -o /dev/null
	# @rm -f a.out
	@$(CC) $(CFLAGS) -c $< -o $@

# ----------------------------
# Assemble ASM files
# ----------------------------
$(OBJ_ROOT_DIR)/%.o: $(SRC_ROOT_DIR)/%.s | obj_dirs
	@echo "AS $< -> $@"
	@$(AS) $(ASFLAGS) $< -o $@

$(OBJ_ROOT_DIR)/%.o: $(SRC_ROOT_DIR)/%.S | obj_dirs
	@echo "AS $< -> $@"
	@$(AS) $(ASFLAGS) $< -o $@

$(OBJ_ROOT_DIR)/%.o: $(SRC_ROOT_DIR)/%.asm | obj_dirs
	@echo "AS $< -> $@"
	@$(AS) $(ASFLAGS) $< -o $@

# ----------------------------
# Link only obj/custom objects dynamically
# ----------------------------
$(INJECT_OBJ):
	@CUSTOM_LINK_OBJS=`$(MINIFIND) $(OBJ_CUSTOM_DIR) -type f -name "*.o" 2>/dev/null`; \
	if [ -z "$$CUSTOM_LINK_OBJS" ]; then \
		echo "No obj/custom/*.o files found, skipping injection object generation."; \
	else \
		echo "Linking obj/custom/*.o -> $@"; \
		mkdir -p $(dir $@); \
		$(LD) -r -T $(LD_SCRIPT) -o $@ $$CUSTOM_LINK_OBJS; \
		for s in `$(OBJDUMP) -h $@ | awk '/\\.gptab|\\.ctors|\\.drectve|\\.init|\\.fini|\\.MIPS/ {print $$2}'`; do \
			$(OBJCOPY) --remove-section=$$s $@ $@.tmp && mv $@.tmp $@; \
		done || true; \
		echo "Generating symbols from $(INJECT_OBJ)" \
		$(LD) -r -Map $(CUSTOM_MAP) -T $(LD_SCRIPT) $(INJECT_OBJ) >/dev/null 2>&1 || true \
		echo "Symbol map updated: $(CUSTOM_MAP)" \
		echo "Linking to binary using $(LD_SCRIPT)"; \
		$(LD) -Map $(CUSTOM_MAP) -T $(LD_SCRIPT) --oformat binary -o $@ $(INJECT_OBJ); \
		echo "Map written to $(CUSTOM_MAP)"; \
		rm -f a.out; \
	fi

# ----------------------------
# Inject into ROM
# ----------------------------
inject: $(BASEROM) $(INJECT_OBJ)
	@$(ARMIPS) inject.asm -root . -sym tmp/syms.txt
	@$(N64CKSUM) $(ROM_OUT) $(ROM_OUT)
	@echo "Patched ROM ready: $(ROM_OUT)"

# ----------------------------
# Print map
# ----------------------------
print_map: $(CUSTOM_MAP)
	@awk '/^[ \t]*0x[0-9a-fA-F]+/ { addr = $$1; name = $$NF; gsub(/^[ \t]+|[ \t]+$$/,"",addr); gsub(/^[ \t]+|[ \t]+$$/,"",name); printf "%s -> %s\n", addr, name; }' $(CUSTOM_MAP)

# ----------------------------
# Clean
# ----------------------------
clean:
	@rm -rf $(OBJ_ROOT_DIR) $(TMP_DIR)
	@$(MINIFIND) . -type f -name '*.d' | xargs -r rm -f
	@$(MINIFIND) $(SRC_ROOT_DIR) -type f -name '*.inc.c' | xargs -r rm -f
	@rm -f $(ROM_OUT) # a.out
	@echo "Clean done."

distclean: clean
	@$(MAKE) -C $(TOOLS_DIR) clean
	@echo "Distclean done."

# ----------------------------
# Include dependencies
# ----------------------------
-include $(CUSTOM_OBJS:.o=.d)

