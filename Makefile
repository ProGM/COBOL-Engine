BREW_PREFIX := $(shell brew --prefix)
SDL_OPTIONS := -lSDL2 -L$(BREW_PREFIX)/opt/sdl2/lib -I$(BREW_PREFIX)/opt/sdl2/include
SDL_TTF_OPTIONS := -lSDL2_ttf -L$(BREW_PREFIX)/opt/sdl2_ttf/lib -I$(BREW_PREFIX)/opt/sdl2_ttf/include
C_INTEROP := -L. -lsdlkeycheck

ENGINE_FILES := CreateGame.o PrepareUpdateGame.o CompleteUpdateGame.o DrawText.o
GAME_FILES := UpdateBall.o UpdatePlayer.o UpdateEnemy.o

.PHONY: all clean

all: PONG

run: PONG
	./PONG

libsdlkeycheck.so: engine/sdl_key_check.c
	gcc -shared -fPIC -o $@ $< $(SDL_OPTIONS)

CreateGame.o: engine/CreateGame.CBL
	cobc -c -O3 $<

PrepareUpdateGame.o: engine/PrepareUpdateGame.CBL
	cobc -c -O3 $<

CompleteUpdateGame.o: engine/CompleteUpdateGame.CBL
	cobc -c -O3 $<

DrawText.o: engine/DrawText.CBL
	cobc -c -O3 $<

UpdateBall.o: game/UpdateBall.CBL
	cobc -c -O3 $<

UpdatePlayer.o: game/UpdatePlayer.CBL
	cobc -c -O3 $<

UpdateEnemy.o: game/UpdateEnemy.CBL
	cobc -c -O3 $<

PONG: $(ENGINE_FILES) $(GAME_FILES) libsdlkeycheck.so PONG.CBL
	cobc -x -O3 PONG.CBL $(ENGINE_FILES) $(GAME_FILES) $(SDL_OPTIONS) $(SDL_TTF_OPTIONS) $(C_INTEROP)

clean:
	rm -f $(ENGINE_FILES) $(GAME_FILES) libsdlkeycheck.so PONG
