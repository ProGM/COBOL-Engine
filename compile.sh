set -e

sdl_options="-lSDL2 -L$(brew --prefix sdl2)/lib -I$(brew --prefix sdl2)/include"

gcc -shared -fPIC -o libsdlkeycheck.so engine/sdl_key_check.c $sdl_options

c_interop="-L. -lsdlkeycheck"

cobc -c -O3 engine/CreateGame.CBL
cobc -c -O3 engine/PrepareUpdateGame.CBL
cobc -c -O3 engine/CompleteUpdateGame.CBL

engine_files="CreateGame.o PrepareUpdateGame.o CompleteUpdateGame.o"

cobc -c -O3 game/UpdateBall.CBL
cobc -c -O3 game/UpdatePlayer.CBL

game_files="UpdateBall.o UpdatePlayer.o"


cobc -x -O3 PONG.CBL $engine_files $game_files $sdl_options $c_interop

./PONG
