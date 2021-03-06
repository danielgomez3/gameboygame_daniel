
#include <gb/gb.h>
#include <stdio.h>
#include "nutty_animated.c"

INT8 playerlocation[2]; //an array of two integers
BYTE jumping; //why not just use a bit?
UINT8 gravity = -2;
UINT8 currentspeedY;
UINT8 floorYposition = 100;





/*calling an actually delay function is CPU intensive, so this will slow down our game by
 * going through this loop*/
void performancedelay(UINT8 numloops){
	UINT8 i;
	for(i=0; i < numloops; i++) {
		wait_vbl_done();
/* That was a gbdk method that waits until the screen has been drawn (the screen draws the pixels from
 * top to bottom*/
	}
}

INT8 wouldhitsurface(UINT8 projectedYPosition){
	if(projectedYPosition >= floorYposition){
		return floorYposition;
	}
	return -1; // else, do this!
}

/*remember, because of the slowness of the game, when the player's coordinate is actuated, it takes
 * the game a while for gravity to kick in and start to decellerate */
void jump(UINT8 spriteid, UINT8 spritelocation[2]){
	INT8 possiblesurfaceY;

	/*Generate the unique jumping sound!*/
	NR10_REG = 0x16; //0001 0110
	NR11_REG = 0x40;
	NR12_REG = 0x73;
	NR13_REG = 0x00;
	NR14_REG = 0xC3;
	//delay(1000);

	if(jumping==0){
		jumping=1;
		currentspeedY = 10;
	}
	// work out the current speed and minus the effect of gravity to lower the effect of gravity
	currentspeedY = currentspeedY + gravity;

	//actually actuate the player's y coordinate to that new speed
	spritelocation[1] = spritelocation[1] - currentspeedY; 

	/*if the player is about to hit the surface, it will return
	 * where the surface is*/
	possiblesurfaceY = wouldhitsurface(spritelocation[1]); 

	/*If the player HAS hit the surace according to the wouldhitsurface()
	 * function: stop jumping, and set his position to the surface permanately!*/
	if(possiblesurfaceY > -1){
		jumping = 0;
		move_sprite(0,spritelocation[0],possiblesurfaceY);
	}
	/*else if the player HASN'T hit the surface, carry on!*/
	else{
		move_sprite(0,spritelocation[0],spritelocation[1]);
	}
}

void main() {
	set_sprite_data(0,2,Nutmeg); //display sprite data

	set_sprite_tile(0,0);

	/*Initialize our player location. This is his spawn coords!*/
	playerlocation[0] = 10; //x coord
	playerlocation[1] = floorYposition; //y coord
	jumping = 0; 

	move_sprite(0,playerlocation[0],playerlocation[1]);

	DISPLAY_ON;
	SHOW_SPRITES;

	while(1){
		if((joypad() & J_A) || (jumping == 1)){
			jump(0,playerlocation);
		}
		if(joypad() & J_LEFT){
			playerlocation[0] = playerlocation[0] - 2; //grab the x pos, change it 2 to the left
			move_sprite(0,playerlocation[0],playerlocation[1]); }
		if(joypad() & J_RIGHT){
			playerlocation[0] = playerlocation[0] + 2; //move his x coord, change it 2 to the right
			move_sprite(0,playerlocation[0],playerlocation[1]); //actually change his position through the game engine 
			}

		performancedelay(5);
	}
}
