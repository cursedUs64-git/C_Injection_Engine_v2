#include "basicheader.h"

<<<<<<< HEAD:src/marioTest.c
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


int hasPerformedGroundPoundJump = 0; // Global variable to track the jump


s32 act_ground_pound_custom(struct MarioState *m) {
=======
u8 hasPerformedGroundPoundJump = 0;
s32 cahstom_act_ground_pound(struct MarioState *m) {
>>>>>>> dea4d5f (Finally fix everything):src/game/act_gp_custom.c
    u32 stepResult;
    f32 yOffset;


    /********************************************************************************
                        Super Mario 64 : Extra Moveset

                          Ground Pound Action List

                     Copyright 2025 Caleb V. Productions

                    This module was programmed by C.Vernon

                               12 - 14/01/2025
     ********************************************************************************/

    if (m->input & INPUT_B_PRESSED) {
        // Ground pound dive 
        set_mario_action(m, ACT_DIVE, 0);
        m->vel[1] = 30.0f; 
        m->forwardVel = 55.0f;
        m->faceAngle[1] = m->intendedYaw;
        return FALSE;
    }

    if ((m->input & INPUT_A_PRESSED) && hasPerformedGroundPoundJump == 0) {
        // Ground Pound Jump (only once per ground touch)
        set_mario_action(m, ACT_TRIPLE_JUMP, 0);
        m->particleFlags |= PARTICLE_VERTICAL_STAR;
        hasPerformedGroundPoundJump = 1; // Prevents further jumps
        return FALSE;
    }

    play_sound_if_no_flag(m, SOUND_ACTION_THROW, MARIO_ACTION_SOUND_PLAYED);

    if (m->actionState == 0) {
        if (m->actionTimer < 10) {
            yOffset = 20 - 2 * m->actionTimer;
            if (m->pos[1] + yOffset + 160.0f < m->ceilHeight) {
                m->pos[1] += yOffset;
                m->peakHeight = m->pos[1];
                vec3f_copy(m->marioObj->header.gfx.pos, m->pos);
            }
        }

        m->vel[1] = -50.0f;
        mario_set_forward_vel(m, 0.0f);

        set_mario_animation(m, m->actionArg == 0 ? MARIO_ANIM_START_GROUND_POUND
                                                 : MARIO_ANIM_TRIPLE_JUMP_GROUND_POUND);
        if (m->actionTimer == 0) {
            play_sound(SOUND_ACTION_SPIN, m->marioObj->header.gfx.cameraToObject);
        }

        m->actionTimer++;
        if (m->actionTimer >= m->marioObj->header.gfx.unk38.curAnim->unk08 + 4) {
            play_sound(0x24228081, m->marioObj->header.gfx.cameraToObject);
            m->actionState = 1;
        }
    } else {
        set_mario_animation(m, MARIO_ANIM_GROUND_POUND);

        stepResult = perform_air_step(m, 0);
        if (stepResult == AIR_STEP_LANDED) {
            hasPerformedGroundPoundJump = 0; // Reset when Mario lands

            if (should_get_stuck_in_ground(m)) {
                play_sound(SOUND_MARIO_OOOF2, m->marioObj->header.gfx.cameraToObject);
                m->particleFlags |= PARTICLE_MIST_CIRCLE;
                set_mario_action(m, ACT_BUTT_STUCK_IN_GROUND, 0);
            } else {
                play_mario_heavy_landing_sound(m, SOUND_ACTION_TERRAIN_HEAVY_LANDING);
                if (!check_fall_damage(m, ACT_HARD_BACKWARD_GROUND_KB)) {
                    m->particleFlags |= PARTICLE_MIST_CIRCLE | PARTICLE_HORIZONTAL_STAR;
                    set_mario_action(m, ACT_GROUND_POUND_LAND, 0);
                }
            }
            set_camera_shake_from_hit(SHAKE_GROUND_POUND);
        } else if (stepResult == AIR_STEP_HIT_WALL) {
            mario_set_forward_vel(m, -16.0f);
            if (m->vel[1] > 0.0f) {
                m->vel[1] = 0.0f;
            }

            m->particleFlags |= PARTICLE_VERTICAL_STAR;
            set_mario_action(m, ACT_BACKWARD_AIR_KB, 0);
        }
    }

    return FALSE;
}
<<<<<<< HEAD:src/marioTest.c


=======
>>>>>>> dea4d5f (Finally fix everything):src/game/act_gp_custom.c
