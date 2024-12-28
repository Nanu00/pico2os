extern int uart_print(char* str);

int main (void) {
    uart_print("Printed from C!\n");
    while (1);
}
