
#include <gb/gb.h>
#include <stdio.h>
#include "nutty_animated.c"

void main(){
	UINT8 currentSpriteIndex = 0; //unsigned int, 8 bits 
				      
	/*start at 0, the first tile, and load 2 tiles from it!*/
	set_sprite_data(0,2,Nutmeg);
	/*load our first sprite (sprite 0), and load from the first tile (second param)*/
	set_sprite_tile(0,0); 
	/*move it 88 across, 78 down. This is more for snapping it across the screen though, not useful*/
	move_sprite(0,88,78); 
	/*we need to set a flag, otherwise this stuff won't show up*/
	SHOW_SPRITES;

	while(1){
		currentSpriteIndex = !currentSpriteIndex;
		set_sprite_tile(0,currentSpriteIndex);
		delay(1000); 
		switch(joypad()){	// make a case for whatever joypad may return:
			case J_LEFT:
				scroll_sprite(0,-10,0); //param1:which sprite, p2:10 bits horizontally left, p3:0 bits vertically
				break;
			
			case J_RIGHT:
				scroll_sprite(0,10,0); //param1:which sprite, p2:10 bits horizontally, p3:0 bits vertically
				break;

			case J_UP:
				scroll_sprite(0,0,-10);
				break;

			case J_DOWN:
				scroll_sprite(0,0,10);
				break;
			}
		/* the cpu in the gameboy would execute this a shiz ton of times in a second, we need
		 * to slow it down with a delay!*/
		delay(100); //not really miliseconds, more like clock cycles
	}
}

/*	NOTES:
* The Gameboy screen is 160px * 144px */
