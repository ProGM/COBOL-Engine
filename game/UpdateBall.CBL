      ******************************************************************
      * Author: ProGM
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. UpdateBall.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 BALL-RECT.
           02 BALL-X USAGE SIGNED-INT VALUE 320.
           02 BALL-Y USAGE SIGNED-INT VALUE 240.
           02 BALL-W USAGE SIGNED-INT VALUE 8.
           02 BALL-H USAGE SIGNED-INT VALUE 8.

       01 BALL-PHY.
           02 BALL-BASE-SPEED COMP-1 VALUE 200.
           02 BALL-SPEED-X COMP-1 VALUE 200.
           02 BALL-SPEED-Y COMP-1 VALUE 200.

       LINKAGE SECTION.
       01 GAME.
           02 SDL-WINDOW USAGE POINTER.
           02 SDL-RENDERER USAGE POINTER.
           02 GAME-WIDTH PIC 9(3) VALUE 640.
           02 GAME-HEIGHT PIC 9(3) VALUE 480.

       01 BALL-POS.
           02 BALL-POS-X COMP-1.
           02 BALL-POS-Y COMP-1.

       01 PLAYER-RECT.
           02 PLAYER-X USAGE SIGNED-INT VALUE 8.
           02 PLAYER-Y USAGE SIGNED-INT VALUE 240.
           02 PLAYER-W USAGE SIGNED-INT VALUE 8.
           02 PLAYER-H USAGE SIGNED-INT VALUE 32.

       01 ENEMY-RECT.
           02 ENEMY-X USAGE SIGNED-INT VALUE 632.
           02 ENEMY-Y USAGE SIGNED-INT VALUE 240.
           02 ENEMY-W USAGE SIGNED-INT VALUE 8.
           02 ENEMY-H USAGE SIGNED-INT VALUE 32.

       01 DELTA-TIME COMP-1.

       01 STATE PIC 9(3) VALUE 0.

       PROCEDURE DIVISION USING
           GAME BALL-POS PLAYER-RECT ENEMY-RECT DELTA-TIME STATE.
       UPDATE-BALL.

           COMPUTE BALL-POS-X = BALL-POS-X + BALL-SPEED-X * DELTA-TIME.
           COMPUTE BALL-POS-Y = BALL-POS-Y + BALL-SPEED-Y * DELTA-TIME.

           MOVE BALL-POS-X TO BALL-X.
           MOVE BALL-POS-Y TO BALL-Y.

           IF BALL-POS-X < 8 THEN
               IF BALL-POS-Y > PLAYER-Y
               AND BALL-POS-Y < PLAYER-Y + PLAYER-H THEN
                   MOVE BALL-BASE-SPEED TO BALL-SPEED-X
               ELSE
                   DISPLAY "GAME OVER"
                   MOVE 1 TO STATE
               END-IF
           END-IF.

           IF BALL-POS-X > GAME-WIDTH - 8 THEN
               IF BALL-POS-Y > ENEMY-Y
               AND BALL-POS-Y < ENEMY-Y + ENEMY-Y THEN
                   COMPUTE BALL-SPEED-X = -BALL-BASE-SPEED
               ELSE
                   DISPLAY "VICTORY"
                   MOVE 2 TO STATE
               END-IF
           END-IF.

           IF BALL-POS-Y < 0 THEN
               MOVE BALL-BASE-SPEED TO BALL-SPEED-Y
           END-IF.

           IF BALL-POS-Y > GAME-HEIGHT THEN
               COMPUTE BALL-SPEED-Y = -BALL-BASE-SPEED
           END-IF.

           CALL "SDL_RenderFillRect" USING
              BY VALUE SDL-RENDERER
              BY REFERENCE BALL-RECT
           END-CALL.
           EXIT PROGRAM.

