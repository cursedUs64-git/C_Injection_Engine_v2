#include <ultra64.h>

#include "sm64.h"
#include "game/area.h"
#include "game/level_update.h"
#include "engine/math_util.h"
#include "game/interaction.h"
#include "game/mario.h"
#include "game/mario_step.h"
#include "game/camera.h"
#include "game/save_file.h"
#include "audio/external.h"
#include "engine/graph_node.h"
#include "game/game.h"
#include "marioTest.h"
#include "game/mario_actions_cutscene.h"

extern int hasPerformedGroundPoundJump;

//     EDIT 09/02/25 - 19:51 GMT  Add the jump code to actually make the gpj work.

s32 act_jump_custom(struct MarioState *m) {
    
    hasPerformedGroundPoundJump = 0;


    if (check_kick_or_dive_in_air(m)) {
        return TRUE;
    }

    if (m->input & INPUT_Z_PRESSED) {
        return set_mario_action(m, ACT_GROUND_POUND, 0);
    }

    play_mario_sound(m, SOUND_ACTION_TERRAIN_JUMP, 0);
    common_air_action_step(m, ACT_JUMP_LAND, MARIO_ANIM_SINGLE_JUMP,
                           AIR_STEP_CHECK_LEDGE_GRAB | AIR_STEP_CHECK_HANG);
    return FALSE;
}
