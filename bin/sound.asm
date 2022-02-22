;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (Linux)
;--------------------------------------------------------
	.module sound
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _joypad
	.globl _delay
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;./src/sound.c:4: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;./src/sound.c:6: NR52_REG = 0x80; // this is 1000 0000 in binary and turns on the sound
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;./src/sound.c:7: NR51_REG = 0x77; // sets volume for left and right channel to max
	ld	a, #0x77
	ldh	(_NR51_REG + 0), a
;./src/sound.c:8: NR50_REG = 0xFF; // this is 1111 1111 in binary, this reg selects which channels we want to use. rn We want all.  
	ld	a, #0xff
	ldh	(_NR50_REG + 0), a
;./src/sound.c:10: while (1){
00104$:
;./src/sound.c:12: UBYTE joypad_state = joypad();
	call	_joypad
	ld	a, e
;./src/sound.c:14: if(joypad_state) {
	or	a, a
	jr	Z, 00104$
;./src/sound.c:20: NR10_REG = 0x16; //0001 0110
	ld	a, #0x16
	ldh	(_NR10_REG + 0), a
;./src/sound.c:21: NR11_REG = 0x40;
	ld	a, #0x40
	ldh	(_NR11_REG + 0), a
;./src/sound.c:22: NR12_REG = 0x73;
	ld	a, #0x73
	ldh	(_NR12_REG + 0), a
;./src/sound.c:23: NR13_REG = 0x00;
	xor	a, a
	ldh	(_NR13_REG + 0), a
;./src/sound.c:24: NR14_REG = 0xC3;
	ld	a, #0xc3
	ldh	(_NR14_REG + 0), a
;./src/sound.c:25: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;./src/sound.c:28: }
	jr	00104$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
