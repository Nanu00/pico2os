.thumb
.comm stack, 0x10000

.global _start
.global stack

.extern main
.type main, %function

.extern UART_puts
.type UART_puts, %function

_start:
    ldr sp, =stack+0x10000

    ldr r0, =outstr
    bl UART_puts

    // Jump to main
    bl kmain

hlt_loop:
    b hlt_loop // Halt loop

.global uart_print
.type uart_print, %function

.data
uart_base: .word 0x40101000
uart_flag_offs: .byte 0x18
outstr: .asciz "Startup...\n"
