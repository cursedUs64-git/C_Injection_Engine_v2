.n64
.open "rom_in.z64", "rom_out.z64", 0
.include "asm/functions.asm"
.include "asm/variables.asm"
.include "asm/sections.asm"
.include "asm/adreso.asm"

<<<<<<< HEAD

.orga 0x120000
.importobj "obj/marioTest.o"
.importobj "obj/marioGPJ.o"


.org 0x8026c9fc
.area 0x8026cd0c-0x8026c9fc
.importobj "obj/badCodeOne.o"
.endarea

.org 0x8026b6a0
.area 0x8026b740-0x8026b6a0
.importobj "obj/badCodeTwo.o"
.endarea
=======
.headersize SEC_CUSTOM_HEADERSIZE
.org SEC_CUSTOM_RAM
.area SEC_CUSTOM_SIZE, 0
>>>>>>> dea4d5f (Finally fix everything)

// import obj file
.importobj "obj/game/act_gp_custom.o"
.align 4
.importobj "obj/game/act_jump_custom.o"
.align 4

.endarea // SEC_CUSTOM_SIZE

/******************** Custom segment loader ********************/

.headersize SEC_MAIN_HEADERSIZE

.org 0x80248AD8
    // overwrite useless branch in one of the bootup functions
    jal __load_custom_segment

.org 0x803396D8
__load_custom_segment:
    // Save return address
    addiu sp, sp, -0x18
    sw    ra, 0x14 (sp)

    // dma_copy(SEC_CUSTOM_SIZE, SEC_CUSTOM_RAM, SEC_CUSTOM_ROM);
    la    t0, SEC_CUSTOM_SIZE
    la    a0, SEC_CUSTOM_RAM
    la    a1, SEC_CUSTOM_ROM
    
    jal   dma_copy
    addu  a2, a1, t0
    nop

    // Restore return address and return
    lw    ra, 0x14 (sp)
    jr    ra
    addiu sp, sp, 0x18

/******************** Function Replacement ********************/

.headersize SEC_MAIN_HEADERSIZE

.org 0x8026C9FC // Overwrite original function call
.importobj "obj/game/act_gp_hook.o"

.org 0x8026B6A0
.importobj "obj/game/act_jump_hook.o"

.close
