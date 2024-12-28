.thumb
vtable:
    b _start // Reset
    b .
    b . // SWI
    b .
    b .
    b .
    b .
    b .

.comm stack, 0x10000

.global _start
.extern main
.type main, %function

_start:
    ldr sp, =stack+0x10000

    ldr r0, =outstr
    bl uart_print
    // Jump to main
    bl main

hlt_loop:
    b hlt_loop // Halt loop

.global uart_print
.type uart_print, %function
// uart_print(ptr_to_str) -> bytes_sent
uart_print:
    .fnstart
    push {r4-r7, lr}

    ldr r4, uart_base
    ldrb r5, uart_flag_offs
    add r5, r5, r4
    mov r6, r0
    mov r0, 0
1:
    ldrb r7, [r5]
    tst r7, 0x20
    bne 1b

    ldrb r7, [r6]
    cbz r7, 2f

    strb r7, [r4]
    add r6, 1
    add r0, 1
    b 1b

2:
    pop {r4-r7, pc}
    .fnend

.data
uart_base: .word 0x40101000
uart_flag_offs: .byte 0x18
outstr: .asciz "Hello, World!\n"
