# Super Mario 64 C Injection Engine V2

Super Mario 64 C Injection Tool by RealGrude and CalebV64.

# Dependencies

### The following tools are required to build (for Windows atleast):

* n64chain
* n64crc
* armips
* MSYS2 

## Folder Format
```
src/
  marioTest.c ... Example ground pound dive code.

include/sm64 ...... Header (.h) files
asm/............... Assembly files with addresses

inject.asm .......... linker tasks, bootstrap code, hook inserts

obj/ ................. Object (.o) files
```
