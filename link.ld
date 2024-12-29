ENTRY(_start)

SECTIONS
{
    .text.vtable 0x10200000 : { *(.text.vtable) }
    . = 0;
    .ARM.exidx : { *(.ARM.exidx) }
    .rodata.str1.1 : { *(.rodata.str1.1) }
    .text : { *(.text*) }
    .data : {*(.data*)}
    .bss : {*(.bss*) *(COMMON*)}
}
