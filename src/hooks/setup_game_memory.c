#include "basicheader.h"

extern u16 gZBuffer[SCREEN_WIDTH * SCREEN_HEIGHT];
extern u16 gFramebuffer0[SCREEN_WIDTH * SCREEN_HEIGHT];
extern u16 gFramebuffer1[SCREEN_WIDTH * SCREEN_HEIGHT];
extern u16 gFramebuffer2[SCREEN_WIDTH * SCREEN_HEIGHT];

#define _entrySegmentRomStart 0x00108a10
#define _entrySegmentRomEnd 0x00108a40
#define _segment2_mio0SegmentRomStart 0x00800000 // Might aswell change load_segment_decompress to be load_segment so people don't get confused?
#define _segment2_mio0SegmentRomEnd 0x0081bb64 // align bruh :angry: it was 81bb63 before. Real hardwaros!
#define _segment2_SegmentRomStart 0x00803156
#define _segment2_SegmentRomEnd _segment2_mio0SegmentRomEnd

void setup_game_memory(void) {
    // UNUSED u8 filler[8];

    // Setup general Segment 0
    set_segment_base_addr(0, (void *) 0x80000000);
    // Create Mesg Queues
    osCreateMesgQueue(&gGfxVblankQueue, gGfxMesgBuf, ARRAY_COUNT(gGfxMesgBuf));
    osCreateMesgQueue(&gGameVblankQueue, gGameMesgBuf, ARRAY_COUNT(gGameMesgBuf));
    // Setup z buffer and framebuffer
    gPhysicalZBuffer = VIRTUAL_TO_PHYSICAL(gZBuffer);
    gPhysicalFramebuffers[0] = VIRTUAL_TO_PHYSICAL(gFramebuffer0);
    gPhysicalFramebuffers[1] = VIRTUAL_TO_PHYSICAL(gFramebuffer1);
    gPhysicalFramebuffers[2] = VIRTUAL_TO_PHYSICAL(gFramebuffer2);
    // Setup Mario Animations
    gMarioAnimsMemAlloc = main_pool_alloc(0x4000, MEMORY_POOL_LEFT);
    set_segment_base_addr(17 /* 0x11 */, (void *) gMarioAnimsMemAlloc);
    setup_dma_table_list(&gMarioAnimsBuf, gMarioAnims, gMarioAnimsMemAlloc);
    // Setup Demo Inputs List
    gDemoInputsMemAlloc = main_pool_alloc(0x800, MEMORY_POOL_LEFT);
    set_segment_base_addr(24, (void *) gDemoInputsMemAlloc);
    setup_dma_table_list(&gDemoInputsBuf, gDemoInputs, gDemoInputsMemAlloc);
    // Setup Level Script Entry
    load_segment(0x10, (void *)_entrySegmentRomStart, (void *)_entrySegmentRomEnd, MEMORY_POOL_LEFT);
    // Setup Segment 2 (Fonts, Text, etc)
    // load_segment_decompress(2, (void *)_segment2_mio0SegmentRomStart, (void *)_segment2_mio0SegmentRomEnd); // i was gonna shift this to cahstom_loads but on an mangler extended rom it crashes? lmfao rom mangler moment
    load_segment(2, (void *)_segment2_SegmentRomStart, (void *)_segment2_SegmentRomEnd, MEMORY_POOL_LEFT);

    cahstom_loads();
}
