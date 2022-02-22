CC = ./developmentapps_gameboy/gbdk/bin/lcc
CFLAGSCOMPILING = -Wa-l -Wl-m -Wl-j -c -o	#-o will be our output filename, set it to our bin folder
CFLAGSLINKING = -Wa-l -Wl-m -Wl-j -o	#-o will name our ROM
OBJS = ./bin/*.o	# These files will need linking
OBJDIR = ./bin
TARGET = ./src/metasprites.c	# This is my program!

main: $(OBJDIR)
	${CC} -Wa-l -Wl-m -Wl-j -c -o ./bin/main.o ${TARGET}
	${CC} -Wa-l -Wl-m -Wl-j -o ./bin/main.gb ./bin/main.o

clean:
	$(RM) $(OBJS)

sound: $(OBJDIR)
	${CC} -Wa-l -Wl-m -Wl-j -c -o 
	${CC} -Wa-l -Wl-m -Wl-j -o ./bin/sound.gb ./bin/sound.o
	
