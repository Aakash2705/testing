#include "driver/VGA.h"

void main() {
	// Create a pointer to a char, and point it to the first text cell
	// of video memory (i.e the top left of the screen)
	char* vid_mem = (char*) 0xb8000;
	// At the address pointed to by vid_mem, store 'X'
	// (display 'X' in the top-left of the screen
	*vid_mem = 'X';
	clear_screen();
	print_string("Hello World!\n");
}
