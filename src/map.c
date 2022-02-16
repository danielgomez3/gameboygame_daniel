#include <gb/gb.h>
#include "./sprites/backgroundmap_example.c"
#include "./sprites/backgroundtiles_example.c"

void main(){
	set_bkg_data(0, 7, backgroundtiles);
	set_bkg_tiles(0,0,40,18,backgroundmap);

	SHOW_BKG;
	DISPLAY_ON;
}

