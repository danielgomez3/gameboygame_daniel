#include <gb/gb.h>
#include <stdio.h>

void main(){
	//These need to be in a specific order!
	NR52_REG = 0x80; // this is 1000 0000 in binary and turns on the sound
	NR51_REG = 0x77; // sets volume for left and right channel to max
	NR50_REG = 0xFF; // this is 1111 1111 in binary, this reg selects which channels we want to use. rn We want all.  

	while (1){
		//UBYTE is an 8-bit (1byte) unsinged integer
		UBYTE joypad_state = joypad();

		if(joypad_state) {
/*create a jumping noise
 * NR10, meaning register 1, channel 0: channel 1 register 0 frequency sweep settings 
 * 7 Unused, 6-4 sweep time. if 0, sweeping is off
 * 3 Sweep direction (1: decrease, 0:increase). We want it to increase in pitch!
 * 2-0 sweep rtshift amount*/
			NR10_REG = 0x16; //0001 0110
			NR11_REG = 0x40;
			NR12_REG = 0x73;
			NR13_REG = 0x00;
			NR14_REG = 0xC3;
			delay(1000);
		}
	}
}
