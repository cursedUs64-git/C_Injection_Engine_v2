# Super Mario 64 C Injection Engine V2

Super Mario 64 C Injection Tool by RealGrude and CalebV64.

## Description

An in-depth paragraph about your project and overview of use.

# Dependencies

### The following tools are required to build:

* n64chain
* n64crc
* armips
* MYSYS2

## Folder Format
```
src/
  marioTest.c ... Example ground pound dive code.

include/sm64
  /PR/ ..... Build Tools
  /audio/ ..... The code used to handle audio.
  /engine/ ......... The games engine code.
  /game/ .......... Most of the behaviours and main C files
  /levels/ .......... course_defines.h & level_defines.h
  /libc/ .......... Maths Equation Defines
asm/.............. Generated Object Files

link.asm .......... linker tasks, bootstrap code, hook inserts
```
