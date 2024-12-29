.section .text.vtable
.extern GenericExceptionHandler
vtable:
    .word stack
    .word _start+1            // Reset
    .word GenericExceptionHandler // NMI
    .word GenericExceptionHandler // HardFault
    .word GenericExceptionHandler // MemManage Fault
    .word GenericExceptionHandler // BusFault
    .word GenericExceptionHandler // UsageFault
    .word GenericExceptionHandler // SecureFault
    .word GenericExceptionHandler // Reserved
    .word GenericExceptionHandler // Reserved
    .word GenericExceptionHandler // Reserved
    .word SVCallHandler           // SVCall
    .word GenericExceptionHandler // DebugMonitor
    .word GenericExceptionHandler // Reserved
    .word GenericExceptionHandler // PendSV
    .word GenericExceptionHandler // SysTick
    .word GenericExceptionHandler // EXTI0
    .word GenericExceptionHandler // EXTI1
