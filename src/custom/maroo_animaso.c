#include "basicheader.h"

// thx trole engen
extern u32 mario_patchable_table_TWO[];
s32 mario_anim_load_patchable_table(struct DmaHandlerList *list, s32 index) {
    s32 ret = FALSE;
    struct DmaTable *table = list->dmaTable;
    u8 *addr;
    s32 size;

    if ((u32)index < table->count) {
        addr = table->srcAddr + table->anim[index].offset;
        size = table->anim[index].size;

        if (list->currentAddr != addr) {
            dma_read(list->bufTarget, addr, addr + size);
            list->currentAddr = addr;
            ret = TRUE;
        }
    }
    else {
        // Out of bounds, oh no !
        // We must now use the other array lol
        index -= table->count;

        addr = (u8*)mario_patchable_table_TWO[index * 2];
        size = mario_patchable_table_TWO[index * 2 + 1];

        if (size > 0 && list->currentAddr != addr) {
            dma_read(list->bufTarget, addr, addr + size);
            list->currentAddr = addr;
            ret = TRUE;
        }
    }
    return ret;
}
