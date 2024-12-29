#include "main.h"
#include "uart.h"
#include "interrupts.h"

#define VTOR_LOC

void kmain (void) {
    UART_puts("Kernel Loaded\n");
    while (1);
}
