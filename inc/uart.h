#define UART_BASE 0x40101000
#define UART_FLAG_OFFSET 0x18
#define UART_FLAG_BUSY_MASK 0x20

void UART_putc(char c);
void UART_puts(char* s);
