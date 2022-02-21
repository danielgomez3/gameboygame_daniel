#include <gb/gb.h>  
#include <stdio.h>
#include "GameCharacter.c"
#include "GameSprites.c"

struct GameCharacter ship;
struct GameCharacter bug;
UBYTE spritesize = 8; //custom global var.  


/*This has a pointer because if we didn't, we wouldn't be referencing the original thing that was
 * passed in as an arument, we would just make a copy, and it would dissapear
 * after the function is over*/
void movegamecharacter(struct GameCharacter* character, UINT8 x, UINT8 y){
  /*This says we want the first sprite id for our character, and we're going to move that to the next x and y
   * coordinates we were told to move from our argument*/
  move_sprite(character->spritids[0], x, y);
  move_sprite(character->spritids[1], x + spritesize, y);
  move_sprite(character->spritids[2], x + spritesize, y + spritesize);
  move_sprite(character->spritids[3], x + spritesize, y + spritesize);
}


void setupship(){
  ship.x = 80; //80 is the middle of the screen  
  ship.y = 130;
  ship.width = 16;
  ship.height = 16;

  /*load the sprites for the ship. Mind you these are all different sprites,
   * and we are trying to stick all of them together to 1 entity*/
  set_sprite_tile(0,0); //set sprite 0, tile 0. This would be the top left of my sprite 
  ship.spritids[0] = 0;
  set_sprite_tile(1,1); //set sprite 1, tile 1. 
  ship.spritids[1] = 1;
  set_sprite_tile(2,2);
  ship.spritids[2] = 2;
  set_sprite_tile(3,3);
  ship.spritids[3] = 3;

  movegamecharacter(&ship, ship.x, ship.y);
}


void setupbug(){
  bug.x = 30; //80 is the middle of the screen  
  bug.y = 0;
  bug.width = 16;
  bug.height = 16;

  /*load the sprites for the bug*/
  set_sprite_tile(4,4); //set sprite 0, tile 4. This would be the top left of my sprite 
  bug.spritids[0] = 4;
  set_sprite_tile(5,5); //T
  bug.spritids[1] = 4;
  set_sprite_tile(6,6);
  bug.spritids[2] = 6;
  set_sprite_tile(7,7);
  bug.spritids[3] = 7;

  movegamecharacter(&bug,bug.x,bug.y);
}




void main(){
  set_sprite_data(0,8, GameSprites);
  setupship();
  setupbug();

	SHOW_SPRITES;
	DISPLAY_ON;

	while(1){


	}

	
}
