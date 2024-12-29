#include <stdint.h>
#include "syscalls.h"

void syscall(uint32_t syscall_num, uint32_t argc, void* argv) {
    asm("svc 0");
}
