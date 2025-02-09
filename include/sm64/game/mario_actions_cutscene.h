#ifndef _MARIO_ACTIONS_CUTSCENE_H
#define _MARIO_ACTIONS_CUTSCENE_H

#include "types.h"


// set_mario_npc_dialog
// actionArg
#define MARIO_DIALOG_STOP       0
#define MARIO_DIALOG_LOOK_FRONT 1 // no head turn
#define MARIO_DIALOG_LOOK_UP    2
#define MARIO_DIALOG_LOOK_DOWN  3
// dialogState
#define MARIO_DIALOG_STATUS_NONE  0
#define MARIO_DIALOG_STATUS_START 1
#define MARIO_DIALOG_STATUS_SPEAK 2

extern void print_displaying_credits_entry(void);
extern void BehEndPeachLoop(void);
extern void BehEndToadLoop(void);
extern s32 geo_switch_peach_eyes(s32 run, struct GraphNode *node, UNUSED s32 a2);
extern s32 mario_ready_to_speak(void);
extern s32 set_mario_npc_dialog(s32);
extern s32 mario_execute_cutscene_action(struct MarioState *);

#endif /* _MARIO_ACTIONS_CUTSCENE_H */
