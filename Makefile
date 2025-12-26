# ==========================
# C Injection Engine v2
# ==========================

include util.mk

# ----------------------------
# Paths / tools
# ----------------------------
SRC_ROOT_DIR    := src
OBJ_ROOT_DIR    := obj
OBJ_CUSTOM_DIR  := $(OBJ_ROOT_DIR)/custom
TMP_DIR         := tmp
TOOLS_DIR       := tools
SM64TOOLS_DIR   := $(TOOLS_DIR)/sm64tools
RECOMP_CC_DIR   := $(TOOLS_DIR)/ido-static-recomp
LD_SCRIPT       := ld/link.ld

# disable this if u wanna debug
MAKEFLAGS += --no-print-directory


# detect prefix for MIPS toolchain
ifneq      ($(call find-command,mips-linux-gnu-ld),)
  CROSS := mips-linux-gnu-
else ifneq ($(call find-command,mips-unknown-linux-gnu-ld),)
  CROSS := mips-unknown-linux-gnu-
else ifneq ($(call find-command,mips64-linux-gnu-ld),)
  CROSS := mips64-linux-gnu-
else ifneq ($(call find-command,mips64-unknown-linux-gnu-ld),)
  CROSS := mips64-unknown-linux-gnu-
else ifneq ($(call find-command,mips-elf-ld),)
  CROSS := mips-elf-
else ifneq ($(call find-command,mips-none-elf-ld),)
  CROSS := mips-none-elf-
else ifneq ($(call find-command,mips64-elf-ld),)
  CROSS := mips64-elf-
else ifneq ($(call find-command,mips64-none-elf-ld),)
  CROSS := mips64-none-elf-
else
  $(error Unable to detect a suitable MIPS toolchain installed)
endif

CC              := gcc
CROSS_CC        := $(RECOMP_CC_DIR)/build/out/cc
CROSS_LD        := $(CROSS)ld
CROSS_AS        := $(CROSS)as
CROSS_OBJDUMP   := $(CROSS)objdump
CROSS_OBJCOPY   := $(CROSS)objcopy
ARMIPS          := $(TOOLS_DIR)/armips # not using system-wide armips anymore cus uh no
N64CKSUM        := $(SM64TOOLS_DIR)/n64cksum
PYTHON := python3 # assuming python is python3 in the host xd change it by urself dumdum (python >=3 is necessary btw)
MINIFIND        := $(PYTHON) $(TOOLS_DIR)/util/minifind.py
GEN_ARMIPS_SYMS := $(PYTHON) $(TOOLS_DIR)/util/gen_armips_syms.py

ROM_IN          := baserom.us.z64
ROM_OUT         := patched.us.z64

SYMBOLS_INC     := $(TMP_DIR)/inject_symbols.inc.asm

# ----------------------------
# Auto-discover headers and sources
# ----------------------------
HEADER_DIRS := $(shell $(MINIFIND) $(SRC_ROOT_DIR) -type f -name "*.h" | xargs -r -n1 dirname | sort -u)
ifeq ($(strip $(HEADER_DIRS)),)
  HEADER_DIRS := $(SRC_ROOT_DIR)
endif
INCLUDE_FLAGS := -Iinclude -Iinclude/sm64 -Iinclude/sm64/libc $(foreach d,$(HEADER_DIRS),-I$(d))

CUSTOM_C_SRCS := $(filter-out %.inc.c, $(shell $(MINIFIND) $(SRC_ROOT_DIR) -type f -name "*.c"))
CUSTOM_ASM_SRCS := $(shell $(MINIFIND) $(SRC_ROOT_DIR) -type f \( -name "*.s" -o -name "*.S" -o -name "*.asm" \))
ASM_S_SRCS   := $(filter %.s,$(CUSTOM_ASM_SRCS))
ASM_S_CAP_SRCS := $(filter %.S,$(CUSTOM_ASM_SRCS))
ASM_ASM_SRCS := $(filter %.asm,$(CUSTOM_ASM_SRCS))

CUSTOM_OBJS := \
  $(patsubst $(SRC_ROOT_DIR)/%.c,$(OBJ_ROOT_DIR)/%.o,$(CUSTOM_C_SRCS)) \
  $(patsubst $(SRC_ROOT_DIR)/%.s,$(OBJ_ROOT_DIR)/%.o,$(ASM_S_SRCS)) \
  $(patsubst $(SRC_ROOT_DIR)/%.S,$(OBJ_ROOT_DIR)/%.o,$(ASM_S_CAP_SRCS)) \
  $(patsubst $(SRC_ROOT_DIR)/%.asm,$(OBJ_ROOT_DIR)/%.o,$(ASM_ASM_SRCS))


OBJ_DIRS := $(sort $(dir $(CUSTOM_OBJS)))

# ----------------------------
# PNG → .inc.c conversion (auto)
# ----------------------------
N64GRAPHICS := $(SM64TOOLS_DIR)/n64graphics

# Find all PNG files under src/
PNG_SRCS := $(shell $(MINIFIND) $(SRC_ROOT_DIR) -type f -name "*.png")
INC_C_SRCS := $(patsubst %.png,%.inc.c,$(PNG_SRCS))

# Conversion rule
%.inc.c: %.png $(N64GRAPHICS)
	@echo "Converting: $< -> $@"
	@$(N64GRAPHICS) -s u8 -i $@ -g $< -f $(lastword $(subst ., ,$(basename $<)))

# ----------------------------
# Flags
# ----------------------------
CFLAGS := $(INCLUDE_FLAGS) -O2 -G0 -Wo,-loopunroll,0 -non_shared -Wab,-r4300_mul -Xcpluscomm -signed -32 -nostdinc -DTARGET_N64 -D_LANGUAGE_C -mips2 -w 
ASFLAGS := -march=vr4300 -mabi=32
CC_CHECK_CFLAGS := -fsyntax-only \
-fsigned-char \
-std=gnu90 \
-DNON_MATCHING \
-DAVOID_UB \
-w $(INCLUDE_FLAGS)
# remove -w for debugging pls sorry for the inconvenience

# ----------------------------
# Phony targets
# ----------------------------
.PHONY: all build tools obj_dirs inject print_map gen_symbols clean distclean info default

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
build: tools info obj_dirs $(CUSTOM_OBJS) $(INJECT_ELF)
	@rm -f a.out
	@echo "Build finished successfully."

# ----------------------------
# Tools
# ----------------------------
tools:
	@echo "Building tools..."
	@$(MAKE) -C $(TOOLS_DIR) all > /dev/null
	@$(MAKE) -C $(SM64TOOLS_DIR) > /dev/null

# ----------------------------
# Ensure directories exist
# ----------------------------
obj_dirs:
	@echo "Creating object directories..."
	@for f in $(CUSTOM_OBJS); do \
	  mkdir -p $$(dirname $$f); \
	done
	@mkdir -p $(TMP_DIR)

# ----------------------------
# Compile C files
# ----------------------------

$(OBJ_ROOT_DIR)/%.o: $(SRC_ROOT_DIR)/%.c | obj_dirs tools
	@echo "CC $< -> $@"
	$(CC) $(CC_CHECK_CFLAGS) -MMD -MP -MF $(OBJ_ROOT_DIR)/$*.d -c $< -o /dev/null
	$(CROSS_CC) $(CFLAGS) -c $< -o $@

# ----------------------------
# Assemble ASM files
# ----------------------------
$(OBJ_ROOT_DIR)/%.o: $(SRC_ROOT_DIR)/%.s | obj_dirs
	@echo "AS $< -> $@"
	@$(CROSS_AS) $(ASFLAGS) $< -o $@

$(OBJ_ROOT_DIR)/%.o: $(SRC_ROOT_DIR)/%.S | obj_dirs
	@echo "AS $< -> $@"
	@$(CROSS_AS) $(ASFLAGS) $< -o $@

$(OBJ_ROOT_DIR)/%.o: $(SRC_ROOT_DIR)/%.asm | obj_dirs
	@echo "AS $< -> $@"
	@$(CROSS_AS) $(ASFLAGS) $< -o $@

# ----------------------------
# Link only obj/custom objects dynamically
# ----------------------------
INJECT_OBJ := $(TMP_DIR)/injection_custom.o
INJECT_ELF := $(TMP_DIR)/injection_custom.elf
CUSTOM_MAP := $(TMP_DIR)/injection_custom.map

# 1️⃣ Relocatable object (for symbols / armips)
$(INJECT_OBJ):
	@CUSTOM_LINK_OBJS=`$(MINIFIND) $(OBJ_CUSTOM_DIR) -type f -name "*.o"`; \
	if [ -z "$$CUSTOM_LINK_OBJS" ]; then \
		echo "No obj/custom/*.o files found, skipping injection."; \
	else \
		echo "Linking relocatable object -> $@"; \
		mkdir -p $(dir $@); \
		$(CROSS_LD) -r -T $(LD_SCRIPT) -o $@ $$CUSTOM_LINK_OBJS; \
		for s in `$(CROSS_OBJDUMP) -h $@ | awk '/\\.gptab|\\.ctors|\\.drectve|\\.init|\\.fini|\\.MIPS/ {print $$2}'`; do \
			$(CROSS_OBJCOPY) --remove-section=$$s $@ $@.tmp && mv $@.tmp $@; \
		done || true; \
	fi

# 2️⃣ Linked ELF (full executable format)
$(INJECT_ELF): $(INJECT_OBJ)
	@echo "Linking full ELF -> $@"
	@mkdir -p $(dir $@)
	@$(CROSS_LD) -r -Map $(CUSTOM_MAP) -T $(LD_SCRIPT) -o $@ $(INJECT_OBJ)

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
-include $(CUSTOM_OBJS:=.d)

