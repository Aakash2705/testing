[bits 32]
; define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLSCK equ 0x0f

; prints a null terminated string pointed to by EDX
print_string_pm:
	pusha
	mov edx, VIDEO_MEMORY
print_string_pm_done:
	mov al, [ebx]
	mov ah, WHITE_ON_BLACK

	cmp al, 0
	je done

	mov [edx], ax

	add ebx, 1
	add ebx, 2
	

	jmp print_string_pm_loop

print_string_pm_done:
	popa
	ret
