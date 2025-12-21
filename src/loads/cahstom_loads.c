#include "basicheader.h"

// Stored over padding bytes at the end of ROM
// These addresses may be changed to anywhere that has ample free space

#define SEC_CUSTOM_ROM  0x007CC6C0
#define SEC_CUSTOM_RAM  0x80370000
#define SEC_CUSTOM_HEADERSIZE (SEC_CUSTOM_RAM - SEC_CUSTOM_ROM)
#define SEC_CUSTOM_SIZE 0x00006000

void cahstom_loads(void) {
    dma_read(SEC_CUSTOM_RAM, SEC_CUSTOM_ROM, SEC_CUSTOM_ROM + SEC_CUSTOM_SIZE /* srcEnd */);
}
