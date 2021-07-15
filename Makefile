ASM=nasm

BUILD_DIR=build

.PHONY: all floppy_image kernel bootloader clean always

#
# Floppy image
#
floppy_image: $(BUILD_DIR)/main_floppy.iso

$(BUILD_DIR)/main_floppy.iso: bootloader kernel
	dd if=/dev/zero of=$(BUILD_DIR)/main_floppy.iso bs=512 count=2880
	dd if=$(BUILD_DIR)/boot.bin of=$(BUILD_DIR)/main_floppy.iso conv=notrunc
	mcopy -i $(BUILD_DIR)/main_floppy.iso $(BUILD_DIR)/kernel.bin "kernel.bin"

#
# Bootloader
#
bootloader: $(BUILD_DIR)/boot.bin

$(BUILD_DIR)/boot.bin: always
	$(ASM) bootloader/boot.asm -f bin -o $(BUILD_DIR)/boot.bin

#
# Kernel
#
kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: always
	# $(ASM) kernel/main.asm -f bin -o $(BUILD_DIR)/kernel.bin

#
# Always
#
always:
	mkdir -p $(BUILD_DIR)

#
# Clean
#
clean:
	rm -rf $(BUILD_DIR)/*
