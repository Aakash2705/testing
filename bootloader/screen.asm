puts:
	push si
	push ax
	push bx
.loop:
	lodsb
	or al, al
	jz .done

	mov ah, 0x0e
	int 0x10
	jmp .loop
.done:
	pop bx
	pop ax
	pop si
	ret


[bits 32]
; define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed by EDX
print_string_pm:
	pusha
	mov edx, VIDEO_MEMORY

print_string_pm_loop:
	mov al, [ebx]
	mov ah, WHITE_ON_BLACK

	cmp al, 0
	je print_string_pm_done

	mov [edx], ax
	
	add ebx, 1
	add edx, 2

	jmp print_string_pm_loop

print_string_pm_done:
	popa
	ret
