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


s32 act_ground_pound(struct MarioState *m) {
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
        m->vel[1] = 30.0f; //[0] is X, [1] is Y,
        // and [2] is Z
        m->forwardVel = 55.0f; // This variable affects
        // the X and Z velocity
        m->faceAngle[1] = m->intendedYaw;
        // faceAngle is a collection of 3 variables for Mario's rotation
        // intendedYaw is basically where the analog stick is pointing
        // relative to the camera
        return FALSE; // This ends the function early, so
        // that other numbers don't affect the dive
    }

        if ((m->input & INPUT_A_PRESSED) && hasPerformedGroundPoundJump == 0) {
        // Ground pound jump
        set_mario_action(m, ACT_TRIPLE_JUMP, 0);
        m->particleFlags |= PARTICLE_VERTICAL_STAR;

        hasPerformedGroundPoundJump = 1; // Mark that the ground pound jump has been performed
        return FALSE; // Ends the function early
    }
     /*******************************************************************************

     *                                  End Moveset.

     ********************************************************************************/

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
            play_sound(SOUND_MARIO_GROUND_POUND_WAH, m->marioObj->header.gfx.cameraToObject);
            m->actionState = 1;
        }
    } else {
        set_mario_animation(m, MARIO_ANIM_GROUND_POUND);

        stepResult = perform_air_step(m, 0);
        if (stepResult == AIR_STEP_LANDED) {
            if (should_get_stuck_in_ground(m)) {
#ifdef VERSION_SH
                queue_rumble_data(5, 80);
#endif
#ifdef VERSION_JP
                play_sound(SOUND_MARIO_OOOF, m->marioObj->header.gfx.cameraToObject);
#else
                play_sound(SOUND_MARIO_OOOF2, m->marioObj->header.gfx.cameraToObject);
#endif
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


