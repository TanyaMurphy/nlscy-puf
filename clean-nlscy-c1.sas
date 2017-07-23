/* Cylcle 1: 1994-95 */

/** samsung;*/
/*x 'cd C:\Users\tanya';*/
/*%let datapath = ./HardDriveOnly/Data/nlscypuf;*/
* surface;
x 'cd C:\Users\Tanya';
%let datapath = ./HardDriveOnly/Data/NLSCYpublic;

/* saved basic permanent  datasets here */
libname nlscy "&datapath";

proc freq data = nlscy.c1 ;
	tables ADMCD06 ammpq02  aDMPD06D aDMCD04 ammsq02*aDMCD04
			ADMCD06*ammpq02; * ammsq02 all miss;
run;

proc sort data = nlscy.c1 ; by AMMCQ01;run;
* (pre-)school: national school grade level asked starting at age 4
                pre-school activities recorded until age 5;
proc freq data = nlscy.c1 ; by AMMCQ01;
	tables  AEDCD01 AEDCD01*AGEHD03
            AACCQ1 AACCQ2AA AACCQ2AA*AGEHD03 AEDCD01*AACCQ1; * AETCQ01 blank in pufs;
run;
proc sort data = nlscy.c1 ; by AGEHD03;run;
proc freq data = nlscy.c1 ; by AGEHD03;
	tables  AHLCQ37*AMMCQ01; * AETCQ01 blank in pufs;
run;


