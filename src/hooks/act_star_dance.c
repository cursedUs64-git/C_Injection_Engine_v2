#include "basicheader.h"

s32 act_star_dance(struct MarioState *m) {
    m->faceAngle[1] = m->area->camera->yaw;
    set_mario_animation(m, m->actionState == 2 ? MARIO_ANIM_RETURN_FROM_STAR_DANCE
                                               : 0xD1 /* windemoAold */);
    general_star_dance_handler(m, 0);
    if (m->actionState != 2 && m->actionTimer >= 40) {
        m->marioBodyState->handState = MARIO_HAND_PEACE_SIGN;
    }
    stop_and_set_height_to_floor(m);
    return FALSE;
}
