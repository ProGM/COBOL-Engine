      ******************************************************************
      * Author: ProGM
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. UpdateEnemy.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 ENEMY-RECT.
           02 ENEMY-X USAGE SIGNED-INT VALUE 632.
           02 ENEMY-Y USAGE SIGNED-INT VALUE 240.
           02 ENEMY-W USAGE SIGNED-INT VALUE 8.
           02 ENEMY-H USAGE SIGNED-INT VALUE 32.

       01 ENEMY-POS-Y COMP-1 VALUE 240.
       01 SPEED-Y COMP-1 VALUE -20.

       01 DELTA-POS.
           02 DELTA-POS-X COMP-1.
           02 DELTA-POS-Y COMP-1.

       01 DIRECTION-Y COMP-1 VALUE 0.

       LINKAGE SECTION.
       01 GAME.
           02 SDL-WINDOW USAGE POINTER.
           02 SDL-RENDERER USAGE POINTER.
           02 GAME-WIDTH PIC 9(3) VALUE 640.
           02 GAME-HEIGHT PIC 9(3) VALUE 480.

       01 DELTA-TIME COMP-1.

       01 BALL-POS.
           02 BALL-POS-X COMP-1.
           02 BALL-POS-Y COMP-1.
              
       PROCEDURE DIVISION USING GAME BALL-POS DELTA-TIME.
       UPDATE-ENEMY.

           COMPUTE SPEED-Y = 0.

           COMPUTE DIRECTION-Y = BALL-POS-Y - ENEMY-POS-Y.

           IF DIRECTION-Y > 0 THEN
               COMPUTE SPEED-Y = 200
           ELSE
               IF DIRECTION-Y < 0 THEN
                   COMPUTE SPEED-Y = -200
               END-IF
           END-IF
       
           COMPUTE ENEMY-POS-Y = ENEMY-POS-Y + SPEED-Y * DELTA-TIME.

           IF ENEMY-POS-Y < 0 THEN
               MOVE 0 TO ENEMY-POS-Y
           END-IF

           IF ENEMY-POS-Y > GAME-HEIGHT - ENEMY-H THEN
               COMPUTE ENEMY-POS-Y = GAME-HEIGHT - ENEMY-H
           END-IF

           MOVE ENEMY-POS-Y TO ENEMY-Y.

           CALL "SDL_RenderFillRect" USING
              BY VALUE SDL-RENDERER
              BY REFERENCE ENEMY-RECT
           END-CALL.
           EXIT PROGRAM.
