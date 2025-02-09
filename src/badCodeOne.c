
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
	act_ground_pound_custom();
}