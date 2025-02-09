# Requirements: MSYS2, n64chain, armips, n64crc

SRC_DIR = src
OBJ_DIR = obj
TMP_DIR=tmp
ASM_DIR=asm
LIB_DIR=lib
SM64API = include
CC = mips64-elf-gcc
LD = mips64-elf-ld
CFLAGS += -I${SM64API}/sm64
CFLAGS += -I${SM64API}/sm64/libc -Os -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0

# Alter these 4 variables according to your need
C_FILES=$(wildcard $(SRC_DIR)/*.c)
O_FILES=$(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(C_FILES))

ROM_IN=rom_in.z64
ROM_OUT=rom_out.z64
LIBRARY_PATH = ld

# 18907136 = 0x1208000
ROM_OFFSET = 18907136

all: $(OBJ_DIR) $(O_FILES) $(ROM_OUT)
$(O_FILES): | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $(C_FILES)
	mv *.o $(OBJ_DIR)

$(ROM_OUT): $(ROM_IN)
	armips inject.asm -root .
	n64crc $(ROM_OUT)

$(OBJ_DIR):
	mkdir $(OBJ_DIR)
clean:
	rm -rf $(OBJ_DIR)
	rm -f $(ROM_OUT)

%.bin: %.o
	$(LD) -o $@ -L ${SM64API}\ld --oformat binary -T ldscript $^

$(TMP_DIR):
	mkdir $(TMP_DIR) convert to windows cmd 