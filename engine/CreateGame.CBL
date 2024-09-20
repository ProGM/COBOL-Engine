      ******************************************************************
      * Author: ProGM
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CreateGame.

       DATA DIVISION.
       LINKAGE SECTION.
           01 GAME.
              02 SDL-WINDOW USAGE POINTER.
              02 SDL-RENDERER USAGE POINTER.
              02 GAME-WIDTH PIC 9(3) VALUE 640.
              02 GAME-HEIGHT PIC 9(3) VALUE 480.
              02 GAME-NAME PIC X(20).
       
           01 SDL-STATUS       USAGE SIGNED-INT.
           01 NULL-POINTER     USAGE POINTER VALUE IS NULL.
           01 ERROR-MESSAGE    PIC X(255).

       PROCEDURE DIVISION USING GAME.
       CREATE-GAME-LOGIC.

           CALL "SDL_Init" USING
               BY VALUE 62001
               RETURNING SDL-WINDOW
           END-CALL.

           CALL "TTF_Init".

           IF SDL-STATUS NOT = 0
               DISPLAY "SDL_Init failed. Exiting."
            *>    MOVE NULL-POINTER TO SDL-WINDOW
            *>    MOVE NULL-POINTER TO SDL-RENDERER
               EXIT PROGRAM
           END-IF.

           DISPLAY "Creating window."

           CALL "SDL_CreateWindow" USING
               BY REFERENCE GAME-NAME
               BY VALUE GAME-WIDTH
               BY VALUE GAME-HEIGHT
               BY VALUE GAME-WIDTH
               BY VALUE GAME-HEIGHT
               BY VALUE 2
               RETURNING SDL-WINDOW
           END-CALL.

        *>    SEGMENTATION FAULT WHEN RUNNING THIS
        *>    IF SDL-WINDOW = NULL-POINTER
        *>        DISPLAY "SDL_CreateWindow failed. Exiting."
        *>        MOVE NULL-POINTER TO SDL-RENDERER
        *>        EXIT PROGRAM
        *>    END-IF.

           CALL "SDL_CreateRenderer" USING
               BY VALUE SDL-WINDOW
               BY VALUE -1
               BY VALUE 1
               RETURNING SDL-RENDERER
           END-CALL.

        *>    SEGMENTATION FAULT WHEN RUNNING THIS
        *>    IF SDL-RENDERER = NULL-POINTER
        *>        DISPLAY "SDL_CreateRenderer failed. Exiting."
        *>        EXIT PROGRAM
        *>    END-IF.


           CALL "SDL_SetRenderDrawColor" USING
               BY VALUE SDL-RENDERER
               BY VALUE 0
               BY VALUE 0
               BY VALUE 0
               BY VALUE 255
           END-CALL.

           CALL "SDL_RenderClear" USING BY VALUE SDL-RENDERER END-CALL.

           DISPLAY "Game window and renderer created successfully."

           EXIT PROGRAM.

