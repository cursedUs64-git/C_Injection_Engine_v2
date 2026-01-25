.n64
.open "baserom.us.z64", "patched.us.z64", 0
.include "asm/sections.asm"
.include "asm/symbols.asm"

/******************** Custom injection ********************/
.headersize SEC_CUSTOM_HEADERSIZE
.orga SEC_CUSTOM_ROM

.importobj "obj/custom/maroo_animaso.o"
.align 4

.definelabel mario_patchable_table_TWO, org()
.word @anim_d1_start, @anim_d1_size
.align 4

// Recommended to align functions evenly (normally 4 bytes) to make it console compatible and avoid runtime errors.

/******************** Custom segment loader ********************/

.headersize SEC_MAIN_HEADERSIZE

// 0x40 bytes of free space because of unused functions (4 functions)
/* stub_debug_1 */
.org 0x802ca370
.area 0x802ca3b0 - 0x802ca370, 0
.importobj "obj/loads/cahstom_loads.o" // function here performs DMA read from the ROM and allocates space in RAM, copying from ROM to RAM
.endarea

// while setting up the game memory, go to the cahstom_loads function. Hook basically.
/* setup_game_memory */
.org 0x80248964
.area 0x80248af0 - 0x80248964, 0
.importobj "obj/hooks/setup_game_memory.o"
.endarea

/******************** Function Replacement ********************/

.headersize SEC_MAIN_HEADERSIZE

/* for extra animations */
.org 0x802509EC // set_mario_animation
JAL     mario_anim_load_patchable_table
.org 0x80250B3C // set_mario_anim_with_accel
JAL     mario_anim_load_patchable_table

// replace animation with cahstom animation in cahstom patchable table (windemoAold)
/* act_star_dance */
.org 0x80258420
.area 0x802584dc - 0x80258420, 0
.importobj "obj/hooks/act_star_dance.o"
.endarea

.headersize 0-orga() // the pointers are relative to the start of the animation
.definelabel @anim_d1_start, orga()
.importobj "obj/anims/windemoAold.o"
.definelabel @anim_d1_size, orga()-@anim_d1_start

.close
