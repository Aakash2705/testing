[bits 16]
[org 0x7c00]

KERNEL_OFFSET equ 0x1000
main:
	mov [BOOT_DRIVE],dl
	
	mov bp, 0x9000
	mov sp, bp


	mov si, MSG_REAL_MODE
	call puts
	call load_kernel
	call switch_to_pm

	jmp $


%include "bootloader/screen.asm"
%include "bootloader/GDT.asm"
%include "bootloader/switch_to_pm.asm"
%include "bootloader/disk_load.asm"

[bits 16]
load_kernel:
	mov si, MSG_LOAD_KERNEL
	call puts

	mov bx, KERNEL_OFFSET
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call disk_load

	ret

[bits 32]
BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_string_pm
	
	call KERNEL_OFFSET


	jmp $

; global vars
BOOT_DRIVE:		db 0
MSG_REAL_MODE:		db "started in real mode", 0x0D, 0x0A, 0
MSG_PROT_MODE: 		db "succesfully landed in 32-bit land", 0
MSG_LOAD_KERNEL:	db "loading kernel into memory", 0x0D, 0x0A, 0

times 510 - ($ - $$) db 0
dw 0xaa55
