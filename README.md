# Super Mario 64 C Injection Engine V2

Super Mario 64 C Injection Tool by RealGrude, SuperMarioXerox13 and CalebV64.

This is an example setup for injecting compiled C code into Super Mario 64.

# Dependencies

### The following tools are required to build (for Windows at least):

* n64chain
* n64crc
* armips
* MSYS2 

## Folder Format
```
src/ ............ Source files, some headers

include/sm64 ...... Header (.h) files
asm/............... Assembly files with addresses

inject.asm .......... linker tasks, bootstrap code, hook inserts

obj/ ................. Object (.o) files
```
