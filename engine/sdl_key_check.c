#include <SDL2/SDL.h>

int check_key_state(int scancode) {
    const Uint8 *state = SDL_GetKeyboardState(NULL);
    return state[scancode];
}
