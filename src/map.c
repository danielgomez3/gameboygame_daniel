#include <gb/gb.h>
#include "backgroundtiles.c"
#include "simplebackgroundmap.c"

void main(){
	set_bkg_data(0, 7, backgorundtiles);
	set_bkg_tiles(0,0,40,18,simplebackgroundmap);

	SHOW_BKG;
	DISPLAY_ON;
	while(1){
		scroll_bkg(1,0);
		delay(100);
	}
}

