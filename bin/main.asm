;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (Linux)
;--------------------------------------------------------
	.module jumping
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _jump
	.globl _wouldhitsurface
	.globl _performancedelay
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _floorYposition
	.globl _gravity
	.globl _Nutmeg
	.globl _currentspeedY
	.globl _jumping
	.globl _playerlocation
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_playerlocation::
	.ds 2
_jumping::
	.ds 1
_currentspeedY::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_Nutmeg::
	.ds 32
_gravity::
	.ds 1
_floorYposition::
	.ds 1
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
;./src/jumping.c:18: void performancedelay(UINT8 numloops){
;	---------------------------------
; Function performancedelay
; ---------------------------------
_performancedelay::
;./src/jumping.c:20: for(i=0; i < numloops; i++) {
	ld	c, #0x00
00103$:
	ld	a, c
	ldhl	sp,	#2
	sub	a, (hl)
	ret	NC
;./src/jumping.c:21: wait_vbl_done();
	call	_wait_vbl_done
;./src/jumping.c:20: for(i=0; i < numloops; i++) {
	inc	c
;./src/jumping.c:25: }
	jr	00103$
;./src/jumping.c:27: INT8 wouldhitsurface(UINT8 projectedYPosition){
;	---------------------------------
; Function wouldhitsurface
; ---------------------------------
_wouldhitsurface::
;./src/jumping.c:28: if(projectedYPosition >= floorYposition){
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #_floorYposition
	sub	a, (hl)
	jr	C, 00102$
;./src/jumping.c:29: return floorYposition;
	ld	e, (hl)
	ret
00102$:
;./src/jumping.c:31: return -1; // else, do this!
	ld	e, #0xff
;./src/jumping.c:32: }
	ret
;./src/jumping.c:36: void jump(UINT8 spriteid, UINT8 spritelocation[2]){
;	---------------------------------
; Function jump
; ---------------------------------
_jump::
	add	sp, #-6
;./src/jumping.c:40: NR10_REG = 0x16; //0001 0110
	ld	a, #0x16
	ldh	(_NR10_REG + 0), a
;./src/jumping.c:41: NR11_REG = 0x40;
	ld	a, #0x40
	ldh	(_NR11_REG + 0), a
;./src/jumping.c:42: NR12_REG = 0x73;
	ld	a, #0x73
	ldh	(_NR12_REG + 0), a
;./src/jumping.c:43: NR13_REG = 0x00;
	xor	a, a
	ldh	(_NR13_REG + 0), a
;./src/jumping.c:44: NR14_REG = 0xC3;
	ld	a, #0xc3
	ldh	(_NR14_REG + 0), a
;./src/jumping.c:47: if(jumping==0){
	ld	hl, #_jumping
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;./src/jumping.c:48: jumping=1;
	ld	(hl), #0x01
;./src/jumping.c:49: currentspeedY = 10;
	ld	hl, #_currentspeedY
	ld	(hl), #0x0a
00102$:
;./src/jumping.c:52: currentspeedY = currentspeedY + gravity;
	ld	a, (#_currentspeedY)
	ld	hl, #_gravity
	add	a, (hl)
	ld	(#_currentspeedY),a
;./src/jumping.c:55: spritelocation[1] = spritelocation[1] - currentspeedY; 
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	hl, #_currentspeedY
	sub	a, (hl)
	ld	b, a
	pop	hl
	push	hl
	ld	(hl), b
;./src/jumping.c:59: possiblesurfaceY = wouldhitsurface(spritelocation[1]); 
	push	bc
	inc	sp
	call	_wouldhitsurface
	inc	sp
	ldhl	sp,	#5
	ld	(hl), e
;./src/jumping.c:65: move_sprite(0,spritelocation[0],possiblesurfaceY);
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#3
;./src/jumping.c:63: if(possiblesurfaceY > -1){
	ld	(hl+), a
	inc	hl
	ld	e, (hl)
	ld	a,#0xff
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00120$
	bit	7, d
	jr	NZ, 00121$
	cp	a, a
	jr	00121$
00120$:
	bit	7, d
	jr	Z, 00121$
	scf
00121$:
	jr	NC, 00104$
;./src/jumping.c:64: jumping = 0;
	ld	hl, #_jumping
	ld	(hl), #0x00
;./src/jumping.c:65: move_sprite(0,spritelocation[0],possiblesurfaceY);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	de, #_shadow_OAM+0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;./src/jumping.c:65: move_sprite(0,spritelocation[0],possiblesurfaceY);
	jr	00108$
00104$:
;./src/jumping.c:69: move_sprite(0,spritelocation[0],spritelocation[1]);
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	(hl-), a
	ld	bc, #_shadow_OAM
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;./src/jumping.c:69: move_sprite(0,spritelocation[0],spritelocation[1]);
00108$:
;./src/jumping.c:71: }
	add	sp, #6
	ret
;./src/jumping.c:73: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;./src/jumping.c:74: set_sprite_data(0,2,Nutmeg); //display sprite data
	ld	de, #_Nutmeg
	push	de
	ld	a, #0x02
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;./src/jumping.c:79: playerlocation[0] = 10; //x coord
	ld	hl, #_playerlocation
	ld	(hl), #0x0a
;./src/jumping.c:80: playerlocation[1] = floorYposition; //y coord
	ld	de, #(_playerlocation + 1)
	ld	a, (#_floorYposition)
	ld	(de), a
;./src/jumping.c:81: jumping = 0; 
	ld	hl, #_jumping
	ld	(hl), #0x00
;./src/jumping.c:83: move_sprite(0,playerlocation[0],playerlocation[1]);
	ld	hl, #(_playerlocation + 1)
	ld	b, (hl)
	ld	hl, #_playerlocation
	ld	c, (hl)
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;./src/jumping.c:85: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;./src/jumping.c:86: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;./src/jumping.c:88: while(1){
00109$:
;./src/jumping.c:89: if((joypad() & J_A) || (jumping == 1)){
	call	_joypad
	bit	4, e
	jr	NZ, 00101$
	ld	a, (#_jumping)
	dec	a
	jr	NZ, 00102$
00101$:
;./src/jumping.c:90: jump(0,playerlocation);
	ld	de, #_playerlocation
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_jump
	add	sp, #3
00102$:
;./src/jumping.c:92: if(joypad() & J_LEFT){
	call	_joypad
	bit	1, e
	jr	Z, 00105$
;./src/jumping.c:93: playerlocation[0] = playerlocation[0] - 2; //grab the x pos, change it 2 to the left
	ld	a, (#_playerlocation + 0)
	dec	a
	dec	a
	ld	(#_playerlocation),a
;./src/jumping.c:94: move_sprite(0,playerlocation[0],playerlocation[1]); }
	ld	hl, #(_playerlocation + 1)
	ld	b, (hl)
	ld	c, a
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;./src/jumping.c:94: move_sprite(0,playerlocation[0],playerlocation[1]); }
00105$:
;./src/jumping.c:95: if(joypad() & J_RIGHT){
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00107$
;./src/jumping.c:96: playerlocation[0] = playerlocation[0] + 2; //move his x coord, change it 2 to the right
	ld	a, (#_playerlocation + 0)
	add	a, #0x02
	ld	(#_playerlocation),a
;./src/jumping.c:97: move_sprite(0,playerlocation[0],playerlocation[1]); //actually change his position through the game engine 
	ld	hl, #(_playerlocation + 1)
	ld	c, (hl)
	ld	b, a
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;./developmentapps_gameboy/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;./src/jumping.c:97: move_sprite(0,playerlocation[0],playerlocation[1]); //actually change his position through the game engine 
00107$:
;./src/jumping.c:100: performancedelay(5);
	ld	a, #0x05
	push	af
	inc	sp
	call	_performancedelay
	inc	sp
;./src/jumping.c:102: }
	jr	00109$
	.area _CODE
	.area _INITIALIZER
__xinit__Nutmeg:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x05	; 5
	.db #0x45	; 69	'E'
	.db #0x47	; 71	'G'
	.db #0x47	; 71	'G'
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x2a	; 42
	.db #0x3e	; 62
	.db #0x5c	; 92
	.db #0x7c	; 124
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x2e	; 46
	.db #0x6e	; 110	'n'
	.db #0x99	; 153
	.db #0x9d	; 157
	.db #0x3c	; 60
	.db #0x2c	; 44
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__gravity:
	.db #0xfe	; 254
__xinit__floorYposition:
	.db #0x64	; 100	'd'
	.area _CABS (ABS)
