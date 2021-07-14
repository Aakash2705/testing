[bits 16]
[org 0x7c00]

main:
	mov bp, 0x9000
	mov sp, bp
	; move the contents of MSG_REAL_MODE to al


	mov si, MSG_REAL_MODE
	call puts

	call switch_to_pm

	jmp $


%include "bootloader/screen.asm"
%include "bootloader/GDT.asm"
%include "bootloader/switch_to_pm.asm"

[bits 32]
BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_string_pm

	jmp $

; global vars
MSG_REAL_MODE:		db "started in real mode", 0
MSG_PROT_MODE: 		db "succesfully landed in 32-bit land", 0

times 510 - ($ - $$) db 0
dw 0xaa55
