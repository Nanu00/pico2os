target=$(BUILD_DIR)/kernel

CC=clang
AS=clang
LD=ld.lld

BUILD_DIR=build
SRC_DIR=src

CFLAGS=-target arm-none-eabi -mcpu=cortex-m33 -mfloat-abi=soft -march=armv8m.main+fp+dsp -mthumb -nostdlib -g -fPIC
ASFLAGS=$(CFLAGS)
LDFLAGS=-T link.ld

C_SRC=src/main.c
AS_SRC=src/start.s

C_OBJECTS=$(patsubst %.c,%.o,$(C_SRC:$(SRC_DIR)/%=$(BUILD_DIR)/%))
AS_OBJECTS=$(patsubst %.s,%.o,$(AS_SRC:$(SRC_DIR)/%=$(BUILD_DIR)/%))

kernel: $(C_OBJECTS) $(AS_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

$(C_OBJECTS): $(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -c $(CFLAGS) -o $@ $^ 

$(AS_OBJECTS): $(BUILD_DIR)/%.o: $(SRC_DIR)/%.s
	$(CC) -c $(CFLAGS) -o $@ $^ 

all: kernel $(C_OBJECTS) $(AS_OBJECTS)

.PHONY: clean run

clean:
	rm $(C_OBJECTS) $(AS_OBJECTS) kernel

run: all
	qemu-system-arm -M musca-a -m 128M -nographic -s -S -kernel kernel
