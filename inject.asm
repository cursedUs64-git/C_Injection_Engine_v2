.n64
.open "rom_in.z64", "rom_out.z64", 0
.include "asm/functions.asm"
.include "asm/variables.asm"
.include "asm/sections.asm" // this comes useful when it is needed for shygoo's c injection method
.include "asm/adreso.asm"
.headersize 0x80245000

.org 0x8026c9fc
.area 0x8026cd0c-0x8026c9fc
.importobj "obj/marioTest.o"
.endarea

// .org 0x802c76d4
// .area 0x80281188-0x802c76d4
// .importobj "obj/mariot2.o"
// .endarea

//.org 0x802BD680
//.area 0x802BD8D0-0x802BD680
//.importobj "obj/marioTest.o"
//.endarea

.close
