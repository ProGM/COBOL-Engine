      ******************************************************************
      * Author: ProGM
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PrepareUpdateGame.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  TEMP-DELTA       PIC 9(10) COMP-5 VALUE 0.
       01  CURRENT-TIME       PIC 9(10) COMP-5 VALUE 0.
       01  LAST-TIME          PIC 9(10) COMP-5 VALUE 0.
       01  THOUSAND           COMP-1 VALUE 1000.0.

       LINKAGE SECTION.
           01 GAME.
              02 SDL-WINDOW USAGE POINTER.
              02 SDL-RENDERER USAGE POINTER.
              02 GAME-WIDTH PIC 9(3) VALUE 640.
              02 GAME-HEIGHT PIC 9(3) VALUE 480.
              02 GAME-NAME PIC X(20).

           01 DELTA-TIME COMP-1 VALUE 0.
       
       
       PROCEDURE DIVISION USING GAME DELTA-TIME.
       PREPARE-UPDATE-GAME-LOGIC.
           CALL "SDL_GetTicks"
               RETURNING CURRENT-TIME
           END-CALL.

           SUBTRACT LAST-TIME FROM CURRENT-TIME GIVING TEMP-DELTA.
           COMPUTE DELTA-TIME = TEMP-DELTA / THOUSAND.

           MOVE CURRENT-TIME TO LAST-TIME.

           CALL "SDL_SetRenderDrawColor" USING
              BY VALUE SDL-RENDERER
              BY VALUE 0
              BY VALUE 0
              BY VALUE 0
              BY VALUE 255
           END-CALL.

           CALL "SDL_RenderClear" USING BY VALUE SDL-RENDERER END-CALL.

           CALL "SDL_SetRenderDrawColor" USING
              BY VALUE SDL-RENDERER
              BY VALUE 255
              BY VALUE 255
              BY VALUE 255
              BY VALUE 255
           END-CALL.
           
           EXIT PROGRAM.

