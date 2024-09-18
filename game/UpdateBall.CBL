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
           02 BALL-POS-X COMP-1 VALUE 320.
           02 BALL-POS-Y COMP-1 VALUE 240.

       LINKAGE SECTION.
       01 GAME.
           02 SDL-WINDOW USAGE POINTER.
           02 SDL-RENDERER USAGE POINTER.
           02 GAME-WIDTH PIC 9(3) VALUE 640.
           02 GAME-HEIGHT PIC 9(3) VALUE 480.

       01 DELTA-TIME COMP-1.

       PROCEDURE DIVISION USING GAME DELTA-TIME.
       UPDATE-BALL.

           COMPUTE BALL-POS-X = BALL-POS-X + BALL-SPEED-X * DELTA-TIME.
           COMPUTE BALL-POS-Y = BALL-POS-Y + BALL-SPEED-Y * DELTA-TIME.

           MOVE BALL-POS-X TO BALL-X.
           MOVE BALL-POS-Y TO BALL-Y.

           IF BALL-POS-X < 8 THEN
               MOVE BALL-BASE-SPEED TO BALL-SPEED-X
           END-IF.

           IF BALL-POS-X > GAME-WIDTH - 8 THEN
               COMPUTE BALL-SPEED-X = -BALL-BASE-SPEED
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

