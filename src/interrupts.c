#include <stdint.h>
#include "main.h"
#include "uart.h"

void GenericExceptionHandler() {
    UART_puts("!EXCEPTION OCCURED!\n");
    // TODO: Implement panic behaviour
    while (1);
}

void SVCallHandler(uint32_t svc_num, uint32_t argc, void* argv) {
    UART_puts("Syscall ");
    UART_putc(svc_num / 100 + 0x30);
    UART_putc((svc_num / 10) % 10 + 0x30);
    UART_putc(svc_num % 10 + 0x30);
    UART_puts(" executed\n");
}
