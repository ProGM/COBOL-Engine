      ******************************************************************
      * Author: ProGM
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN-METHOD.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
        77 SCENE USAGE POINTER.
        01 GAME.
           02 SDL-WINDOW USAGE POINTER.
           02 SDL-RENDERER USAGE POINTER.
           02 GAME-WIDTH PIC 9(3) VALUE 640.
           02 GAME-HEIGHT PIC 9(3) VALUE 480.
           02 GAME-NAME PIC X(20) VALUE 'My Game Window'.

    *>    01 BALL-VEC.
    *>        02 BALL-VEC-X COMP-1 VALUE 200.
    *>        02 BALL-VEC-Y COMP-1 VALUE 200.

       01 SDL-PIXELFORMAT USAGE IS UNSIGNED-INT.

       01 DELTA-TIME COMP-1 VALUE 0.
 
        01 E.
         05 E_TYPE USAGE BINARY-INT UNSIGNED.
         05 USAGE BINARY-CHAR OCCURS 60 TIMES.
        77 E_RETURN PIC 9(1).
        01 NULL-POINTER     USAGE POINTER VALUE IS NULL.
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

           CALL "UpdatePlayer" USING
                BY REFERENCE GAME
                BY REFERENCE DELTA-TIME
           END-CALL.

           CALL "UpdateBall" USING
                BY REFERENCE GAME
                BY REFERENCE DELTA-TIME
           END-CALL.

           CALL "CompleteUpdateGame" USING
                BY REFERENCE GAME
           END-CALL.
  
           PERFORM CHECK_QUIT.

        *>    CALL "CreateScene" USING
        *>        BY VALUE 62001
        *>        RETURNING SCENE
        *>    END-CALL.

        *>    CALL "CreateSprite" USING
        *>        BY VALUE "ball.png"
        *>        BY VALUE 320
        *>        BY VALUE 240
        *>        RETURNING BALL
        *>    END-CALL.

        *>    CALL "CreateSprite" USING
        *>        BY VALUE "bar.png"
        *>        BY VALUE 0
        *>        BY VALUE 240
        *>        by reference SCENE
        *>        RETURNING PLAYER
        *>    END-CALL.

        *>    CALL "CreateSprite" USING
        *>        BY VALUE "bar.png"
        *>        BY VALUE 640
        *>        BY VALUE 240
        *>        by reference SCENE
        *>        RETURNING ENEMY
        *>    END-CALL.


        *>    PERFORM UNTIL SHOULD-EXIT = 0
        *>        CALL "GetInput" USING
        *>            BY VALUE GAME
        *>            RETURNING INPUTS
        *>        END-CALL.

        *>        IF INPUTS == 1
        *>            PLAYER-X = PLAYER-X - 1
        *>        END-IF

        *>        IF INPUTS == 2
        *>            PLAYER-Y = PLAYER-Y + 1
        *>        END-IF

        *>        CALL "UpdatePhysics" USING
        *>           BY REFERENCE BALL
        *>        END-CALL.

        *>        CALL "UpdateGame" USING
        *>            BY VALUE GAME
        *>            BY VALUE SCENE
        *>            RETURNING SHOULD-EXIT
        *>        END-CALL.
        *>    END-PERFORM.
            PERFORM CHECK_QUIT.
       CHECK_QUIT.
            CALL "SDL_PollEvent"
             USING BY REFERENCE E
             RETURNING E_RETURN
            END-CALL.

            PERFORM UNTIL E_RETURN EQUALS 0
             IF E_TYPE=256 THEN
              DISPLAY "EXIT"
              STOP RUN
             END-IF
             CALL "SDL_PollEvent"
              USING BY REFERENCE E
              RETURNING E_RETURN
             END-CALL
            END-PERFORM.

       END PROGRAM MAIN-METHOD.
