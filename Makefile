# Requirements: MSYS2, n64chain, armips, n64crc

SRC_DIR  := src
TMP_DIR  := tmp
ASM_DIR  := asm
LIB_DIR  := lib
SM64API  := include
OBJ_DIR  := obj

CC := mips64-elf-gcc
LD := mips64-elf-ld

INCLUDE_DIRS := $(shell C:/msys64/usr/bin/find.exe $(SRC_DIR) -type d)
INCLUDE_FLAGS := $(foreach dir,$(INCLUDE_DIRS),-I$(dir))

CFLAGS += $(INCLUDE_FLAGS) -I${SM64API}/sm64 -I${SM64API}/sm64/libc
CFLAGS += -O2 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0

C_FILES := $(shell C:/msys64/usr/bin/find.exe $(SRC_DIR) -type f -name "*.c")
O_FILES := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(C_FILES))

OBJ_DIRS := $(sort $(dir $(O_FILES)))

ROM_IN  := rom_in.z64
ROM_OUT := rom_out.z64

LIBRARY_PATH := ld
ROM_OFFSET := 18907136 

all: $(OBJ_DIRS) $(O_FILES) $(ROM_OUT)

$(OBJ_DIRS):
	mkdir -p $@

$(TMP_DIR):
	mkdir -p $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIRS)
	$(CC) $(CFLAGS) -c $< -o $@

$(ROM_OUT): $(ROM_IN)
	armips inject.asm -root .
	n64crc $(ROM_OUT)

%.bin: %.o
	$(LD) -o $@ -L $(SM64API)/ld --oformat binary -T ldscript $^

clean:
	rm -rf $(OBJ_DIR) $(TMP_DIR)
	rm -f $(ROM_OUT)
