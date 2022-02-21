# include <gb/gb.h>

/*general character struct: id, position, graphics  
 * all characters use 4 sprites*/
struct GameCharacter {
  UBYTE spritids[4];
  UINT8 x;
  UINT8 y;
  UINT8 width;
  UINT8 height;
}
