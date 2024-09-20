      ******************************************************************
      * Author: ProGM
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CompleteUpdateGame.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 E.
             05 E_TYPE USAGE BINARY-INT UNSIGNED.
             05 USAGE BINARY-CHAR OCCURS 60 TIMES.
           77 E_RETURN PIC 9(1).

       LINKAGE SECTION.
           01 GAME.
              02 SDL-WINDOW USAGE POINTER.
              02 SDL-RENDERER USAGE POINTER.
              02 GAME-WIDTH PIC 9(3) VALUE 640.
              02 GAME-HEIGHT PIC 9(3) VALUE 480.
              02 GAME-NAME PIC X(20).

           01 EXIT-CODE USAGE BINARY-LONG.

       PROCEDURE DIVISION USING GAME EXIT-CODE.
       COMPLETE-UPDATE-GAME.
           CALL "SDL_RenderPresent"
              USING BY VALUE SDL-RENDERER
           END-CALL.

           CALL "SDL_Delay" USING BY VALUE 1 END-CALL.
           
           PERFORM CHECK_QUIT.

           EXIT PROGRAM.

       CHECK_QUIT.
           CALL "SDL_PollEvent"
             USING BY REFERENCE E
             RETURNING E_RETURN
           END-CALL.
           PERFORM UNTIL E_RETURN EQUALS 0
             IF E_TYPE=256 THEN
              MOVE 256 TO EXIT-CODE
              STOP RUN
             END-IF
             CALL "SDL_PollEvent"
              USING BY REFERENCE E
              RETURNING E_RETURN
             END-CALL
           END-PERFORM.
