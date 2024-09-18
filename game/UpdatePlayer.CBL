      ******************************************************************
      * Author: ProGM
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. UpdatePlayer.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 PLAYER-RECT.
           02 PLAYER-X USAGE SIGNED-INT VALUE 8.
           02 PLAYER-Y USAGE SIGNED-INT VALUE 240.
           02 PLAYER-W USAGE SIGNED-INT VALUE 8.
           02 PLAYER-H USAGE SIGNED-INT VALUE 32.

       01 PLAYER-POS-Y COMP-1 VALUE 240.
       01 SPEED-Y COMP-1 VALUE -20.

       01 NUMBER-OF-ELEMENTS USAGE SIGNED-INT VALUE 0.
       
       01 W-KEY-SCANCODE USAGE BINARY-LONG VALUE 26.
       01 W-KEY-STATE USAGE BINARY-LONG.

       01 S-KEY-SCANCODE USAGE BINARY-LONG VALUE 22.
       01 S-KEY-STATE USAGE BINARY-LONG.

       LINKAGE SECTION.
       01 GAME.
           02 SDL-WINDOW USAGE POINTER.
           02 SDL-RENDERER USAGE POINTER.
           02 GAME-WIDTH PIC 9(3) VALUE 640.
           02 GAME-HEIGHT PIC 9(3) VALUE 480.

       01 DELTA-TIME COMP-1.
       01 DIRECTION PIC S9(3).
              
       PROCEDURE DIVISION USING GAME DELTA-TIME.
       UPDATE-PLAYER.

           CALL "check_key_state" USING
               BY VALUE W-KEY-SCANCODE
               RETURNING W-KEY-STATE
           END-CALL

           CALL "check_key_state" USING
               BY VALUE S-KEY-SCANCODE
               RETURNING S-KEY-STATE
           END-CALL

           COMPUTE SPEED-Y = 0.

           IF W-KEY-STATE > 0 THEN
               COMPUTE SPEED-Y = -200
           ELSE
               IF S-KEY-STATE > 0 THEN
                   COMPUTE SPEED-Y = 200
               END-IF
           END-IF
       
           COMPUTE PLAYER-POS-Y = PLAYER-POS-Y + SPEED-Y * DELTA-TIME.

           IF PLAYER-POS-Y < 0 THEN
               MOVE 0 TO PLAYER-POS-Y
           END-IF

           IF PLAYER-POS-Y > GAME-HEIGHT - PLAYER-H THEN
               COMPUTE PLAYER-POS-Y = GAME-HEIGHT - PLAYER-H
           END-IF

           MOVE PLAYER-POS-Y TO PLAYER-Y.

           CALL "SDL_RenderFillRect" USING
              BY VALUE SDL-RENDERER
              BY REFERENCE PLAYER-RECT
           END-CALL.
           EXIT PROGRAM.

