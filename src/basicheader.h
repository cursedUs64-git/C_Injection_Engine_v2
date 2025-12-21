#ifndef _MARIOTEST_
#define _MARIOTEST_

#include <ultra64.h>
#include "sm64.h"
#include "audio/external.h"
#include "behavior_data.h"
#include "dialog_ids.h"
#include "engine/behavior_script.h"
#include "engine/math_util.h"
#include "engine/surface_collision.h"
#include "engine/surface_load.h"
#include "level_table.h"
#include "game/obj_behaviors.h"
#include "game/obj_behaviors_2.h"
#include "game/object_helpers.h"
#include "object_constants.h"
#include "game/object_list_processor.h"
#include "game/platform_displacement.h"
#include "game/rendering_graph_node.h"
#include "game/save_file.h"
#include "game/spawn_sound.h"
#include "game/mario_actions_cutscene.h"
#include "game/camera.h"
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
#include "seq_ids.h"
#include "game/ingame_menu.h"
#include "game/memory.h"


#define o gCurrentObject

s8 obj_return_home_if_safe(struct Object *obj, f32 homeX, f32 y, f32 homeZ, s32 dist);
s8 obj_check_if_facing_toward_angle(u32 base, u32 goal, s16 range);
void obj_check_floor_death(s16 collisionFlags, struct Surface *floor);
s8 is_point_within_radius_of_mario(f32 x, f32 y, f32 z, s32 dist);

void treat_far_home_as_mario(f32 threshold);
s32 obj_forward_vel_approach(f32 target, f32 delta);
s32 obj_resolve_object_collisions(s32 *targetYaw);
s32 obj_bounce_off_walls_edges_objects(s32 *targetYaw);
s32 obj_resolve_collisions_and_turn(s16 targetYaw, s16 turnSpeed);
s16 obj_random_fixed_turn(s16 delta);
s16 random_linear_offset(s16 base, s16 range);
s32 obj_smooth_turn(s16 *angleVel, s32 *angle, s16 targetAngle, f32 targetSpeedProportion, s16 accel, s16 minSpeed, s16 maxSpeed);
s32 approach_f32_ptr(f32 *px, f32 target, f32 delta);
s32 obj_update_standard_actions(f32 scale);
s32 cur_obj_init_anim_and_check_if_end(s32 arg0);
s32 cur_obj_init_anim_check_frame(s32 arg0, s32 arg1);
s32 clamp_s16(s16 *value, s16 minimum, s16 maximum);

#endif // _MARIOTEST_
