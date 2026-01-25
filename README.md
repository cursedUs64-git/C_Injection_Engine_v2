# Super Mario 64 C Injection Engine v2

Super Mario 64 C Injection Engine by RealGrude, SuperMarioXerox13 and CalebV64.

This is an example setup for injecting compiled C code into Super Mario 64.

# Dependencies

### The following tools are required to build (for NT and GNU/Linux at least):

* GNU toolchain
* MSYS2 or any MingW64 subsystem (for NT)
* Python >= 3

## Folder Format
```
src/ .............. Source files, some headers

include/sm64 ...... Header (.h) files
asm/............... Assembly files with addresses

inject.asm ........ Linker tasks, bootstrap code, hook inserts

obj/ .............. Object (.o) files
```
