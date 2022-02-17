#include <gb/gb.h>
#include "simplebackgroundmap.c"
#include "backgroundtiles.c"
#include "windowmap.c"
#include <gb/font.h>


void main(){
	font_t min_font;  
	/*font loads 25 tiles, so for our tiles to not overwrite them,  we need to start at 26
	 * You can't change that, fonts will alwyas occupy these tiles so you have to work around that*/
	font_init();
	min_font = font_load(font_min);
	font_set(min_font);

	/*see: font_t min font*/
	set_bkg_data(37,7, backgorundtiles);
	set_bkg_tiles(0,0,40,18,simplebackgroundmap);
	/*start drawing something to our window
	* Start at 0,0, width=5 tiles wide, 1 high, and a map for the window.
	* (we have to tell it which tiles of the tile data to load up */
	set_win_tiles(0,0,5,1,windowmap);
	move_win(7,120); //takes an x and a y coord

	SHOW_BKG;
	SHOW_WIN; // show our new window
	DISPLAY_ON;
	
	while(1){
	scroll_bkg(1,0);
	delay(100);
	}
	
	
}
