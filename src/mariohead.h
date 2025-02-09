#include "PR/ultratypes.h"
#include "game/ingame_menu.h"

/* header */
#define SELECT 1
extern s8 gDialogLineNum;
extern s8 gLastDialogResponse;
extern u8 gMenuHoldKeyIndex;
extern u8 gMenuHoldKeyTimer;
extern s16 gMenuMode;
extern s8 gDialogBoxState;
extern f32 gDialogBoxOpenTimer;
extern f32 gDialogBoxScale;
extern s16 gDialogTextPos;
extern s16 gDialogID;
extern f32 gDefaultSoundArgs[3];

typedef struct {
	int		code;
	char	line;
	short	posx;
	short	posy;
	unsigned char *string;
} Message;

extern void render_select_cursor(s8 minIndex, s8 maxIndex);
extern s16 render_select_message(void);

extern void render_dialog_entries(void);
extern void handle_dialog_text_and_pages(s8 colorMode, struct DialogEntry *dialog, s8 lowerBound);
extern void render_dialog_box_type(struct DialogEntry *dialog, s8 linesPerBox);

enum DialogBoxType {
    DIALOG_TYPE_ROTATE, // used in NPCs and level messages
    DIALOG_TYPE_ZOOM    // used in signposts and wall signs and etc
};
enum DialogBoxState {
    DIALOG_STATE_OPENING,
    DIALOG_STATE_VERTICAL,
    DIALOG_STATE_HORIZONTAL,
    DIALOG_STATE_CLOSING
};


extern void *seg2_dialog_table[];
extern void *seg2_debug_text_table[];
s8 gDialogBoxType;