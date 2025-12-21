/* template linker script for custom injection */

SECTIONS
{
  . = 0x8040F510;
  . = ALIGN(4);
  .text : { *(.text) }
  . = ALIGN(4);
  .rodata : { *(.rodata) }
  . = ALIGN(4);
  .data : { *(.data) }
  /DISCARD/ : {
    *(.gptab*)
    *(.ctors)
    *(.dtors)
    *(.init)
    *(.fini)
    *(.drectve)
    *(.comment)
    *(.note*)
  }
}

