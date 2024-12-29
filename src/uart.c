#include "uart.h"

void UART_putc(char c) {
    while (*(char*)(UART_BASE+UART_FLAG_OFFSET) & UART_FLAG_BUSY_MASK);

    *(char*)(UART_BASE) = c;
}

void UART_puts(char* s) {
    while (*s != '\0') {
        UART_putc(*s);
        s++;
    }
}
