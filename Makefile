target=$(BUILD_DIR)/kernel

CC=clang
AS=clang
LD=ld.lld

BUILD_DIR=build
SRC_DIR=src

CFLAGS=-target arm-none-eabi -mcpu=cortex-m33 -mfloat-abi=soft -march=armv8m.main+fp+dsp -mthumb -nostdlib -g -fPIC
ASFLAGS=$(CFLAGS)
LDFLAGS=-T link.ld

C_SRC=src/main.c src/interrupts.c src/uart.c src/syscalls.c
AS_SRC=src/start.s src/vtable.s

C_INCLUDES=inc/
AS_INCLUDES=inc/

C_OBJECTS=$(patsubst %.c,%.o,$(C_SRC:$(SRC_DIR)/%=$(BUILD_DIR)/%))
AS_OBJECTS=$(patsubst %.s,%.o,$(AS_SRC:$(SRC_DIR)/%=$(BUILD_DIR)/%))

kernel: $(C_OBJECTS) $(AS_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

$(C_OBJECTS): $(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -c $(CFLAGS) -I$(C_INCLUDES) -o $@ $^ 

$(AS_OBJECTS): $(BUILD_DIR)/%.o: $(SRC_DIR)/%.s
	$(CC) -c $(CFLAGS) -I$(AS_INCLUDES) -o $@ $^

all: kernel $(AS_OBJECTS) $(C_OBJECTS)

.PHONY: clean run

clean:
	rm $(C_OBJECTS) $(AS_OBJECTS) kernel

run: all
	qemu-system-arm -M musca-a -m 128M -nographic -kernel kernel

debug: all
	qemu-system-arm -M musca-a -nographic -s -S -kernel kernel

debugv: all
	qemu-system-arm -M musca-a -d in_asm,exec,int,cpu,unimp,guest_errors -nographic -s -S -kernel kernel
