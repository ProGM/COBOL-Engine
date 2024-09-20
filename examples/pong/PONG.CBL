      ******************************************************************
      * Author: ProGM
      * Date:
      * Purpose: Playing
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN-METHOD.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01 GAME.
           02 SDL-WINDOW USAGE POINTER.
           02 SDL-RENDERER USAGE POINTER.
           02 GAME-WIDTH PIC 9(3) VALUE 640.
           02 GAME-HEIGHT PIC 9(3) VALUE 480.
           02 GAME-NAME PIC X(20) VALUE 'PONG IN COBOL'.
           02 GAME-STATE PIC 9(3) VALUE 0. *> 0 = game, 1 = gameover, 2 = victory

       01 BALL-POS.
           02 BALL-POS-X COMP-1 VALUE 320.
           02 BALL-POS-Y COMP-1 VALUE 240.

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

       01 DELTA-TIME COMP-1 VALUE 0.

       01 UPDATE-EXIT-CODE USAGE BINARY-LONG VALUE 0.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

           DISPLAY "Starting..."

           CALL "CreateGame" USING
              BY REFERENCE GAME
           END-CALL.

           PERFORM UPDATE-GAME FOREVER.
           GOBACK.
       UPDATE-GAME.
           CALL "PrepareUpdateGame" USING
                BY REFERENCE GAME
                BY REFERENCE DELTA-TIME
           END-CALL.

           IF GAME-STATE EQUALS 0 THEN
               PERFORM UPDATE_BASE_GAME
           ELSE
                IF GAME-STATE EQUALS 1 THEN
                     PERFORM UPDATE_GAMEOVER
                ELSE
                     PERFORM UPDATE_VICTORY
                END-IF
           END-IF.

           CALL "CompleteUpdateGame" USING
                BY REFERENCE GAME
                BY REFERENCE UPDATE-EXIT-CODE
           END-CALL.
  
           IF UPDATE-EXIT-CODE = 256 THEN
               DISPLAY "Exit"
               CALL "TTF_Quit"

               STOP RUN
           END-IF.
       UPDATE_BASE_GAME.
           CALL "UpdatePlayer" USING
                BY REFERENCE GAME
                BY REFERENCE PLAYER-RECT
                BY REFERENCE DELTA-TIME
           END-CALL.

           CALL "UpdateEnemy" USING
                BY REFERENCE GAME
                BY REFERENCE BALL-POS
                BY REFERENCE ENEMY-RECT
                BY REFERENCE DELTA-TIME
           END-CALL.

           CALL "UpdateBall" USING
                BY REFERENCE GAME
                BY REFERENCE BALL-POS
                BY REFERENCE PLAYER-RECT
                BY REFERENCE ENEMY-RECT
                BY REFERENCE DELTA-TIME
                BY REFERENCE GAME-STATE
           END-CALL.
       UPDATE_GAMEOVER.
           CALL "DrawText" USING
                BY REFERENCE GAME
                BY REFERENCE "Game Over"
                BY REFERENCE 320
                BY REFERENCE 240
                BY REFERENCE 80
           END-CALL.
       UPDATE_VICTORY.
           CALL "DrawText" USING
                BY REFERENCE GAME
                BY REFERENCE "Victory"
                BY REFERENCE 320
                BY REFERENCE 240
                BY REFERENCE 80
           END-CALL.

       END PROGRAM MAIN-METHOD.
