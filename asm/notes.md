REMEMBER: Add the normal address with 0x80245000.

ASM uses 32 different registers to help with storing values. Each register can store exactly 4 bytes, or 8 hexadecimal numbers. This is called a word, or long. Similarly, a halfword (or short) is 2 bytes. Most ASM commands work with halfwords.

R0 - Register 0. Const, always zero.
V0, V1 - return Values of funcs.
A0, A3 - Funcs params
T0, T9 and S0, S7 - General registers. S regs save forever until manually changed
AT - Assembler Temporary (used for assembling macros)
K0 / K1 - Reserved for the kernel
GP - Global Pointer
SP - Stack Pointer
FP - Frame Pointer
RA - Return Address (automatically set by the JAL command)

ADDU  - ADD Unsigned,
    ADDU usage: ADDU R1, R2, R3
    Result: R1 is set to the sum of R2 and R3.

ADDIU - ADD Immediate Unsigned,
    ADDIU usage: ADDIU R1, R2, 0x????
    Result: R1 is set to the sum of R2 and R3.

LUI means Load Upper Immediate. It is useful for assigning a 4-byte value to any register.
    Usage: LUI R1, 0x????
    Result: R1 is set to 0x????0000.

OR and ORI(mmediate) perform a bitwise OR operation.
    OR usage: OR R1, R2, R3
        Result: R1 is now R2 || R3 (bitwise)
    ORI usage: ORI R1, R2, 0x????
        Result: R1 is now R2 || 0x???? (bitwise)

L(oad) W(ord), L(oad) H(alfword) and L(oad) B(yte) all load a certain number of bytes into the given register from the given address.
    Usage: LB R1, 0x????(R2)
    Result: Loads the byte from RAM address 0x???? + R2 into R1.
        LH loads 2 bytes and LW loads 4. (Important! The addition of the value and R2 functions the same as ADDIU: if the value is greater than 0x7FFF, it will be treated as a negative.)

S(ave) W(ord), Save Halfword and Save Byte function similarly to the loading commands, but instead save the value of a register to an address.
    Usage: SB R1, 0x????(R2)
    Result: The last byte of R1 is stored at 0x???? + R2.

NOP means No Operation. It is simply an empty command that does nothing. Sometimes needed in a (conditional) jump if space cannot be saved


Func Wrapper:

```
.orga 0x861C0 
ADDIU SP, SP, 0xFFE8
SW RA, 0x14(SP)

LW RA, 0x14(SP)
JR RA
ADDIU SP, SP, 0x18
```

Jumps: J, JAL, JALR, JR
J: Jumps to the address. Eg:
    J 0x802A3754 // jumps to 0x802A3754
    NOP
    // the ROM address of this RAM address is 0x5E754, 
    // remember to subtract 0x80245000

JAL: Same like J, but sets register RA to the current address, i.e., the one before jumping. Eg:
    JAL 0x802A3754 // jumps to 0x802A3754
    // now the function wrapper can work correctly,
    // and the function should return us here

JR: Same like J but with a register instead. Eg: JR RA

JALR: Same like JAL but with a register instead too

Branches: Jump but with a condition.
BEQ (Branch on Equal), BNE (Branch on Not Equal), BGT (Branch on Greater Than), BGE (Branch on Greater Than or Equal To), BLT (Branch on Less Than) and BLE (Branch on Less Than or Equal To),
BGTZ, BGEZ, BLTZ and BLEZ

Eg: B(whatever) r1, r2, subroutine

Mario's Actions: https://hack64.net/wiki/doku.php?id=super_mario_64:actions

