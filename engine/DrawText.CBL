      ******************************************************************
      * Author: ProGM
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DrawText.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 FONT-PTR USAGE POINTER.

           01 TEXT-COLOR.
               05 RED   PIC 9(3) USAGE COMP-5 VALUE 255.
               05 GREEN PIC 9(3) USAGE COMP-5 VALUE 255.
               05 BLUE  PIC 9(3) USAGE COMP-5 VALUE 255.
               05 ALPHA PIC 9(3) USAGE COMP-5 VALUE 255.

           01 TEXT-SURFACE USAGE POINTER.
           01 TEXT-TEXTURE USAGE POINTER.

           01 TEXT-RECT.
               05 TEXT-RECT-X USAGE SIGNED-INT VALUE 0.
               05 TEXT-RECT-Y USAGE SIGNED-INT VALUE 0.
               05 TEXT-RECT-W USAGE SIGNED-INT VALUE 640.
               05 TEXT-RECT-H USAGE SIGNED-INT VALUE 480.

       LINKAGE SECTION.
           01 GAME.
              02 SDL-WINDOW USAGE POINTER.
              02 SDL-RENDERER USAGE POINTER.
              02 GAME-WIDTH PIC 9(3) VALUE 640.
              02 GAME-HEIGHT PIC 9(3) VALUE 480.
              02 GAME-NAME PIC X(20).

           01 TEXT-CONTENT PIC X(100).
           01 TEXT-X USAGE SIGNED-INT VALUE 320.
           01 TEXT-Y USAGE SIGNED-INT VALUE 240.
           01 TEXT-SIZE USAGE SIGNED-INT VALUE 24.
       
       PROCEDURE DIVISION USING
           GAME TEXT-CONTENT TEXT-X TEXT-Y TEXT-SIZE.
       DRAW-TEXT-LOGIC.

           IF FONT-PTR = NULL THEN
               CALL "TTF_OpenFont" USING
                   BY REFERENCE "./fonts/visitor1.ttf"
                   BY VALUE TEXT-SIZE
                   RETURNING FONT-PTR
               END-CALL

               IF FONT-PTR = NULL THEN
                   DISPLAY "TTF_OpenFont failed. Exiting."
                   EXIT PROGRAM
               END-IF
           END-IF.
           
           CALL "TTF_RenderText_Solid" USING
               BY VALUE FONT-PTR
               BY REFERENCE TEXT-CONTENT
               BY CONTENT TEXT-COLOR
               RETURNING TEXT-SURFACE
           END-CALL.

           CALL "SDL_CreateTextureFromSurface" USING
               BY VALUE SDL-RENDERER
               BY VALUE TEXT-SURFACE
               RETURNING TEXT-TEXTURE
           END-CALL.

           CALL "SDL_GetClipRect" USING
               BY VALUE TEXT-SURFACE
               BY REFERENCE TEXT-RECT
           END-CALL.

           COMPUTE TEXT-RECT-X = TEXT-X - (TEXT-RECT-W / 2).
           COMPUTE TEXT-RECT-Y = TEXT-Y - (TEXT-RECT-H / 2).

           CALL "SDL_RenderCopy" USING
               BY VALUE SDL-RENDERER
               BY VALUE TEXT-TEXTURE
               BY REFERENCE NULL
               BY REFERENCE TEXT-RECT
           END-CALL.

           CALL "SDL_FreeSurface" USING
               BY VALUE TEXT-SURFACE
           END-CALL.

           EXIT PROGRAM.

