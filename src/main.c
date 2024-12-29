#include "main.h"
#include "syscalls.h"
#include "uart.h"
#include "interrupts.h"

#define VTOR_LOC

void kmain (void) {
    UART_puts("Kernel Loaded\n");

    syscall(10, 0, 0);

    while (1);
}
