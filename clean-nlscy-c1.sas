/* Cylcle 1: 1994-95 */

* samsung;
x 'cd C:\Users\tanya';

* surface;
*x 'cd C:\Users\Tanya';

/* saved basic permanent  datasets here */
libname nlscy "./git-repos/nlscy-puf/data";

proc freq data = nlscy.c1 ;
	tables ADMCD06 ammpq02  aDMPD06D aDMCD04 ammsq02*aDMCD04
			ADMCD06*ammpq02; * ammsq02 all miss;
run;

proc sort data = nlscy.c1 ; by AMMCQ01;run;
* (pre-)school: national school grade level asked starting at 
               age 4, pre-school activities recorded until age 5;
proc freq data = nlscy.c1 ; by AMMCQ01;
	tables  AEDCD01 AEDCD01*AGEHD03
            AACCQ1 AACCQ2AA AGEHD03*AACCQ2AA AEDCD01*AACCQ2AA; 
			* AETCQ01 blank in pufs;
run;
proc sort data = nlscy.c1 ; by AGEHD03;run;
proc freq data = nlscy.c1 ; by AGEHD03;
	tables  AHLCQ37*AMMCQ01; * AETCQ01 blank in pufs;
run;

proc sort data=nlscy.c1 ;by ACRCQ1A AEDCD01;
proc freq data=nlscy.c1 (where = (AMMCQ01 <= 5));
  by ACRCQ1A AEDCD01;tables ACRCD03;
run;
