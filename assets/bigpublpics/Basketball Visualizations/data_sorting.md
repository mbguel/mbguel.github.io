### About

Put how data was sorted in there.
Like how PBP was sorted?
How FT data was sorted?
How 2-3 point data was sorted?

Put the .txt files
Put the process you put in

How to parse the old NBA season data:
1) Open Excel --> Import, Find .txt file. Use tab delimiter only.

2) Click Sheet2. Import same sheet again. But this time, use delimiter (use Tab and Colon).

3) Then from there, use in a column right next to the split up time values to convert time into seconds. (60 * Minute) + (Seconds)

4) Delete the extra columns from Sheet2. (easier for MATLAB to conduct import later)

5) Import into MATLAB. Import everything from Sheet1(you can delete TimeRemaining later) Then Import the SecondsTime column from Sheet2.

Note: The first line of all these variables don't mean anything, so we shall remove it later.

6) Remove the TimeRemaining variable. Save the workspace as pbp_2010-11.mat

7) Then import saved workspace variables into PBP_Parse.m, run file.
8) Add final line of code to bottom: "BasketBallData2011 d"

#### MATLAB "d" variable is a structure with the following fields:
Team1 (Away)  
Team2 (Home)  
time (Time of made shot)  
scoringTeam (which team scored)  
scoringType (what type of shot was made)  
