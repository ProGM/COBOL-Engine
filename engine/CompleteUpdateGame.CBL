      ******************************************************************
      * Author: ProGM
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CompleteUpdateGame.

       DATA DIVISION.
       LINKAGE SECTION.
           01 GAME.
              02 SDL-WINDOW USAGE POINTER.
              02 SDL-RENDERER USAGE POINTER.
              02 GAME-WIDTH PIC 9(3) VALUE 640.
              02 GAME-HEIGHT PIC 9(3) VALUE 480.
              02 GAME-NAME PIC X(20).

           01 DELTA-TIME COMP-1 VALUE 0.
       
       
       PROCEDURE DIVISION USING GAME.
       COMPLETE-UPDATE-GAME.
           CALL "SDL_RenderPresent"
              USING BY VALUE SDL-RENDERER
           END-CALL.

           CALL "SDL_Delay" USING BY VALUE 1 END-CALL.

           EXIT PROGRAM.

