/* Cylcle 1: 1994-95 */

* samsung;
*x 'cd C:\Users\tanya';

* surface;
x 'cd C:\Users\Tanya';

/* saved basic permanent  datasets here */
libname nlscy "./git-repos/nlscy-puf/data";

proc freq data = nlscy.c1 ;
	tables ADMCD06 ammpq02 admcd03 aDMPD06D aDMCD04 ammsq02*aDMCD04
			ADMCD06*ammpq02 admcd06b admcd06c; * ammsq02 all miss;
run;
/* Does the child live with a bio, step-, or adoptive mother (yes = 1/no = 0)?
   Is the PMK the child's mother (bio, step, or adopt)? 
    If not, is the PMK the child's father (bio, step, or adopt)? 
   If the PMK is the child's mother or father, is the PMK's spouse the 
    child's father or mother?
*/   
data c1d;set c1c;
	if admcd03 in (11, 21, 22, 31, 41, 43, 44, 51, 71) & admcd06c = 3
       then liveswithmom = 1; 
    if admcd03 in (42, 45, 46, 47, 61, 72) | admcd06c ne 3
       then liveswithmom = 0;
	if admcd06 in (11, 12, 13) then pmkmom = 1; else pmkmom = 0;
	if admcd06 in (21, 22, 23) then pmkdad = 1; else pmkdad = 0;
	if admcd06B in (11, 12, 13) then spouse = 1; 
	if admcd06B = 50 then spouse = 0; 
	if admcd06B in (21, 22, 23) then spouse = 2; 
run;
proc sort data = c1a; by AMMCQ01;run;
proc freq data = c1a;by AMMCQ01;
	tables pmkmom*liveswithmom  pmkdad*liveswithmom;
run;
proc freq data = c1a (where = (liveswithmom = 1));by AMMCQ01;
	tables AGEHD03 pmkmom*spouse;
run;

/* childcare

*/



* (pre-)school: national school grade level asked starting at 
               age 4, pre-school activities recorded until age 5;
proc freq data = c1a (where = (liveswithmom = 1)); by AMMCQ01;
	tables  AEDCD01 AEDCD01*AGEHD03 AACCQ2B
            AACCQ1 AACCQ2AA AGEHD03*AACCQ2AA AEDCD01*AACCQ2AA; 
			* AETCQ01 blank in pufs;
run;
data c1b;set c1a;
	if AACCQ2AA = 1 then AACCM2AA = 1;
		if AACCQ1 = 2 | AACCQ2AA = 2 then AACCM2AA = 0;
	if ACRCD04 < 996 & ACRCQ1A = 1 then do;
		ACRCM1A = 2; ACRCM04 = ACRCD04;
		if ACRCD04 < 10 then ACRCM1A = 1;
	end;
	if ACRCD04 = 996 & ACRCQ1A = 2 then do;
		ACRCM1A = 0; ACRCM04 = 0;
	end;
run; 
proc freq data = c1b (where = (liveswithmom = 1)); 
	tables ACRCD04 ACRCM04; 
run;
proc sort data = c1b; by AMMCQ01 AGEHD03;run;
proc freq data = c1b (where = (liveswithmom = 1)); by AMMCQ01 AGEHD03;
	tables AACCM2AA AACCM2AA*AEDCD01 AEDCD01 ACRCM1A; 
run;
proc freq data = c1b (where = (liveswithmom = 1)); by AMMCQ01;
	tables AGEHD03*AEDCD01; 
run;
proc sort data = nlscy.c1 ; by AGEHD03;run;
proc freq data = nlscy.c1 ; by AGEHD03;
	tables  AHLCQ37*AMMCQ01; * AETCQ01 blank in pufs;
run;

proc sort data=nlscy.c1 ;by ACRCQ1A AEDCD01;
proc freq data=nlscy.c1 (where = (AMMCQ01 <= 5));
  by ACRCQ1A AEDCD01;tables ACRCD03;
run;
