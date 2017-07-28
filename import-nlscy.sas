/** samsung;*/
/*x 'cd C:\Users\tanya';*/
/*%let datapath = ./HardDriveOnly/Data/nlscypuf;*/
* surface;
x 'cd C:\Users\Tanya';
%let datapath = ./HardDriveOnly/Data/NLSCYpublic;

/* Cylcle 1: 1994-95 */
proc import out = c11 
	file = "&datapath./nlscy-89M0015-E-1994-1995-c-1-r-2-primary-file_F1.dta" 
	dbms = STATA replace;
run;
proc contents data = c11;run;
proc univariate data = c11;var AWTCW01;run;
data c11;set c11 ;rename AWTCW01 = AWTCW01C;run;
proc sort data = c11; by AIDHD01 CHILDID;run;
proc import 
	datafile = "&datapath./nlscy-89M0015-E-1994-1995-c-1-r-2-secondary-file_F1.dta" 
	dbms = STATA replace
	out = c12;
run;
proc univariate data = c12;var AWTCW01;run;
proc sort data = c12; by AIDHD01 CHILDID;run;
data c1; merge c11 c12; by AIDHD01 CHILDID;run;
proc datasets library = work nolist;
	delete c11 c12;
quit;

/* Cylcle 2: 1996-97 */
proc import 
	datafile = "&datapath./nlscy-89M0015-E-1996-1997-c-2-primary-file_F1.dta" 
	dbms = STATA replace
	out = c2 ;
run;
proc univariate data = c2;var BWTCW01C;run;
/* Cylcle 3: 1998-99 */
proc import 
	datafile = "&datapath./nlscy-89M0015-E-1998-1999-c-3-primary-file_F1.dta" 
	dbms = STATA replace
	out = c3;
run;
proc univariate data = c3;var CWTCW01C;run;

/* go to checkvars.sas if need to update variable lists */

/* save basic permanent  datasets for cleaning in next scripts */
libname nlscy "./git-repos/nlscy-puf/data";

/* Cycle 1: keep and standardize chosen vars */
data c1b;set c1;
	CID = CHILDID;
	HID = aidhd01;
	format cid z6. hid z7.; 
run;
proc sort data = c1b;by hid cid;run;
proc univariate data = c1b;var cid hid AWTCW01;run;
data c1c;
	retain HID CID;
	set c1b (keep = HID CID 
AACCQ1 AACCQ2AA AACCQ2B ABECS01 ABECS02 ABECS03 ABECS04 ABECS06 ABECS07 ABECS08 ABECS09 
ABECS10 ACHPQ1J ACHSQ1J ACRCD01 ACRCD02 ACRCD03 ACRCD04 ACRCD06 ACRCQ04 ACRCQ06 ACRCQ07 
ACRCQ1A ACRCQ1B ACRCQ1BA ACRCQ1BB ACRCQ1C ACRCQ1CA ACRCQ1CB ACRCQ1D ACRCQ1DA ACRCQ1E 
ACRCQ1EA ACRCQ1F ACRCQ1FA ACRCQ1G ACRCQ1GA ACRCQ1GB ACRCQ1H ACRCQ1HA ACRCQ1I ACRCQ1IA 
ACRCQ1J ACRCQ1JA ADMCD03 ADMCD04 ADMCD06 ADMCD06B ADMCD06C ADMCD08 ADMCD09 ADMCD10 
ADMCD14 ADMCD16 ADMCD18 ADMCD18B ADMCD19 ADMCD19B ADMCD20 ADMHD06F ADMPD06A ADMPD06D 
ADMSD06E ADPPS01 AEDCD01 AEDCQ02 AEDCQ03 AEDCQ12B AEDCQ12C AEDCQ12D AEDPD01 AEDPD02 AEDPQ02 
AEDPQ03 AEDPQ05 AEDPQ06 AEDSD01 AEDSD02 AEDSQ02 AEDSQ03 AEDSQ05 AEDSQ06 AETCQ01 AETCS28A 
AETCS28B AETCS28C AETCS28D AETCS28E AFNHQ01M AFNHQ02 AFNHS01 AGEHD01 AGEHD02 AGEHD03 
AHHHQ01 AHHHQ02 AHHHQ02B AHHHQ06B CHILDID AHLCD02 AHLCQ01 AHLCQ02 AHLCQ03B
AHLCQ04A AHLCQ05 AHLCQ31 AHLCQ36 AHLCQ37 AHLCQ38 AHLCQ39 AHLCQ41 AHLCQ42 AHLCQ43B AHLCQ45L 
AHLCQ46 AHLCQ47A AHLCQ47B AHLCQ48A AHLCQ48B AHLCQ48C AHLCQ48D AHLCQ49 AHLCQ50 AHLCQ51B 
AHLCQ52M AHLPQ01 AHLPQ02 AHLPQ03 AHLPQ04 AHLPQ05 AHLPQ06 AHLSQ01 AHLSQ02 AHLSQ03 AHLSQ04 
AHLSQ05 AHLSQ06 AIDHD01 AINHD02B AINHD05 AINHD07 AINHD08 ALFHD49 ALFHD49B ALFPD01A ALFPD25 
ALFPD51 ALFPQ02 ALFSD01A ALFSD25 ALFSD51 ALFSQ02 AMDCD01 AMDCD02 AMDCD03 AMDCD04 AMDCD06 
AMDCD07 AMDCD08 AMDCD09 AMDCD10 AMDCQ02 AMDCQ13B AMDCQ14B AMDCQ22 AMDCQ25 AMDCQ26 AMDCQ27 
AMMCQ01 AMMCQ02 AMMCQ03A AMMCQ03B AMMCQ03C AMMPQ02 AMMSQ02 AMSCS02 APACS01 APACS02 APACS03 
APACS04 APPCD01 APPCS01 APRCQ26A APRCQ26B APRCQ26C APRCQ26D APRCQ26E APRCQ26F APRCQ26G 
APRCQ26H APRCQ26I APRCQ26J APRCQ26K APRCS01 APRCS02 APRCS03 APRCS04 APRCS05 APRCS06 
ARLCQ07 ARLCQ08 ARLCQ09 ARSPD01 ARSPQ01E ARSSD01 ARSSQ01E ASDPD02B ASDPD03 ASDSD02B 
ASDSD03 ASFHQ01 ASFHS6 ASFHS7 ASPHS01 ATMCQ25 ATMCQ26 ATMCQ27 ATMCQ33 AWTCW01 AWTCW01C
);
run;
/* *run if vars update needed ;
proc contents data = c1c out = c1var;run;
%ds2csv (data = c1var, runmode = b, 
        csvfile = .\git-repos\nlscy-puf\c1vars.csv, 
		labels = N);
*/
proc freq data = c1c (where = (aMMCQ01 < 10));
	tables ADMCD06 ammpq02  aDMPD06D aDMCD04 ammsq02*aDMCD04
			ADMCD06*ammpq02; * ammsq02 all miss;
run;
proc freq data = c1c (where = (aMMCQ01 < 10));
	tables ADMCD06 aDMPD06D aDMCD04;
	format ADMCD06 aDMPD06D aDMCD04 6.;
run;
* if need labels removed (but missing values are coded as missing, so prob. OK) ;
proc datasets lib=work memtype=data;
   modify c1c;
     *attrib _all_ label=' ';
     attrib _all_ format=;
quit;
proc contents data = c1c;run;
data nlscy.c1;set c1c (where = (aMMCQ01 < 10));run;




/* Cycle 2: keep and standardize chosen vars */
data c2b;set c2;
	CID = input(CHILDID, 6.);
	HID = input(bidhd01, 7.);
	format cid z6. hid z7.; 
run;
proc sort data = c2b;by hid cid;run;
proc univariate data = c2b;var cid hid;run;
data c2b;set c2b;
	CID = CID + 200000;
	HID = 10*HID + 2000000;
run;
data c2c;
	retain HID CID;
	set c2b (keep = HID CID
BACCQ1 BACCQ2AA BACCQ2B BBECS01 BBECS02 BBECS03 BBECS04 BBECS06 BBECS07 BBECS08 BBECS09 
BBECS10 BCHPQ1J BCHSQ1J BCRCD02 BCRCD03 BCRCD04 BCRCD06 BCRCQ04 BCRCQ06 BCRCQ07 BCRCQ1A 
BCRCQ1B BCRCQ1BA BCRCQ1BB BCRCQ1C BCRCQ1CA BCRCQ1CB BCRCQ1D BCRCQ1DA BCRCQ1E BCRCQ1EA 
BCRCQ1F BCRCQ1FA BCRCQ1G BCRCQ1GA BCRCQ1GB BCRCQ1H BCRCQ1HA BCRCQ1I BCRCQ1IA BCRCQ1J 
BCRCQ1JA BCRCbD01 BDMCD03 BDMCD04 BDMCD06 BDMCD08 BDMCD09 BDMCD10 BDMCD14 BDMCD16 BDMCD18 
BDMCD18B BDMCD19 BDMCD19B BDMCD20 BDMCbD21 BDMCbD22 BDMCbD26 BDMHD06F BDMPD06A BDMPD06D 
BDMPbD27 BDMSD06E BDMSbD28 BDPPS01 BEDCD01 BEDCQ02 BEDCQ03 BEDCbQ0A BEDPD01 BEDPD02 BEDPQ02 
BEDPQ03 BEDPQ05 BEDPQ06 BEDSD01 BEDSD02 BEDSQ02 BEDSQ03 BEDSQ05 BEDSQ06 BFNHQ01M BFNHQ02 
BFNHS01 BGEHD03 BHHHD06B BHHHQ01 BHHHQ02 BHHHQ02B CHILDID BHLCD02 BHLCQ01 BHLCQ02 BHLCQ03B 
BHLCQ04A BHLCQ05 BHLCQ31 BHLCQ36 BHLCQ37 BHLCQ38 BHLCQ39 BHLCQ41 BHLCQ42 BHLCQ43B BHLCQ45L 
BHLCQ46 BHLCQ47A BHLCQ47B BHLCQ48A BHLCQ48B BHLCQ48C BHLCQ48D BHLCQ49 BHLCQ50 BHLCQ51B 
BHLCQ52M BHLPQ01 BHLPQ02 BHLPQ03 BHLPQ04 BHLPQ05 BHLPQ06 BHLSQ01 BHLSQ02 BHLSQ03 BHLSQ04 
BHLSQ05 BHLSQ06 BIDHD01 BINHD05A BINHD07 BINHD08 BLFHD49B BLFPD25 BLFPD51 BLFPQ02 BLFSD25 
BLFSD51 BLFSQ02 BMDCD01 BMDCD02 BMDCD03 BMDCD04 BMDCD06 BMDCD07 BMDCD08 BMDCD09 BMDCD10 
BMDCQ13B BMDCQ14B BMDCQ22 BMDCQ25 BMDCQ26 BMDCQ27 BMDCbQ29 BMMCQ01 BMMCQ02 BMMCQ03A 
BMMCQ03B BMMCQ03C BMMCbD01 BMMPQ02 BMMSQ02 BMSCS02 BPACS01 BPACS02 BPACS03 BPACS04 BPPCD01 
BPPCS01 BPRCQ26A BPRCQ26B BPRCQ26C BPRCQ26D BPRCQ26E BPRCQ26F BPRCQ26G BPRCQ26H BPRCQ26I 
BPRCQ26J BPRCQ26K BPRCS01 BPRCS02 BPRCS03 BPRCS04 BPRCS05 BPRCS06 BRLCQ07 BRLCQ08 BRLCQ09 
BRSPD01 BRSPQ01E BRSSD01 BRSSQ01E BSDPD02B BSDPD03 BSDSD02B BSDSD03 BTMCQ33 BWTCW01C
);
run;
/* *run if vars update needed ;
proc contents data = c2c out = c2var  nodetails;run;
%ds2csv (data = c2var, runmode = b, csvfile = .\git-repos\nlscy-puf\c2vars.csv, labels = N);
*/
proc freq data = c2c (where = (bMMCQ01 < 10));
	tables  bmmpq02 bmmsq02 bDMPD06D bDMCD04 bmmpq02*bDMCD04; * bDMCD06 all miss;
run;


/* Cycle 3: keep and standardize chosen vars */
data c3b;set c3;
	CID = input(CHILDID, 6.);
	HID = input(cidhd01, 7.);
	format cid z6. hid z7.; 
run;
proc sort data = c3b;by hid cid;run;
proc univariate data = c3b;var cid hid cWTCW01c;run;
data c3b;set c3b;
	CID = CID + 300000;
	HID = 10*HID + 3000000;
run;
data c3c;
	retain HID CID;
	set c3b (keep = HID CID
CACCQ1 CACCQ2AA CACCQ2B CBECS01 CBECS02 CBECS03 CBECS04 CBECS06 CBECS07 CBECS08 CBECS09 
CBECS10 CCRCD02 CCRCD03 CCRCD04 CCRCD06 CCRCQ04 CCRCQ06 CCRCQ07 CCRCQ1B CCRCQ1BA CCRCQ1BB 
CCRCQ1C CCRCQ1CA CCRCQ1CB CCRCQ1D CCRCQ1DA CCRCQ1E CCRCQ1EA CCRCQ1F CCRCQ1FA CCRCQ1G 
CCRCQ1GA CCRCQ1GB CCRCQ1H CCRCQ1HA CCRCQ1IA CCRCc1JA CCRCc1KA CCRCcQ1A CCRCcQ1I CCRCcQ1J 
CCRCcQ1K CCRCcQ2A CDMCD04B CDMCD08 CDMCD09 CDMCD10 CDMPD06D CDMSD06E CDPPS01 CEDCD01 
CEDCQ02 CEDCQ03 CEDPD02 CEDSD02 CFNHQ02 CFNHS01 CGEHD03 CHHHD06B CHHHQ01 CHHHQ02B CHILDID 
CHLCQ01 CHLCQ02 CHLCQ03B CHLCQ04A CHLCQ05 CHLCQ31 CHLCQ36 CHLCQ37 CHLCQ43B CHLCQ46 CHLCQ47A 
CHLCQ47B CHLCQ48A CHLCQ48B CHLCQ48C CHLCQ48D CHLCQ49 CHLPQ01 CHLPQ02 CHLPQ03 CHLPQ06 
CHLPcQ05 CHLPcQ5A CHLSQ01 CHLSQ02 CHLSQ03 CHLSQ06 CHLScQ05 CHLScQ5A CIDHD01 CINHD05A 
CINHD07 CINHD08B CLFPD25 CLFPQ02 CLFSD25 CLFSQ02 CMDCD01 CMDCD02 CMDCD03 CMDCD04 CMDCD06 
CMDCD07 CMDCD09 CMDCD10 CMDCQ26 CMDCbQ29 CMDCcD8A CMMCQ01 CMMCQ02 CMMPQ02 CMMSQ02 CPACS01 
CPACS02 CPACS03 CPACS04 CPPCS01 CPRCQ26A CPRCQ26B CPRCQ26C CPRCQ26D CPRCQ26E CPRCQ26F 
CPRCQ26G CPRCQ26J CPRCQ26K CPRCS01 CPRCS02 CPRCS03 CPRCS04 CPRCS05 CPRCS06 CRLCQ07 CRLCQ08 
CRLCQ09 CSFHQ01 CSFHS6 CSPHS01 CTMCQ33 CTMCcQ25 CTMCcQ26 CTMCcQ27 CWBCcQ02 CWBCcQ1B 
CWBCcQ1C CWBCcQ2B CWBCcQ4A CWBCcQ4B CWBCcQ4C CWTCW01C
);
run;
/* *run if vars update needed ;
proc contents data = c3c out = c3var  nodetails;run;
%ds2csv (data = c3var, runmode = b, csvfile = .\git-repos\nlscy-puf\c3vars.csv, labels = N);
*/
proc freq data = c3c (where = (CMMCQ01 < 10));
	tables cmmpq02 cmmsq02 CDMPD06D CDMCD04B cmmsq02*CDMCD04B;
run;







proc datasets library = work nolist;
	delete c1b c2b c3b c1p c1pc2p c1var c2p c2var 
           c3p callp callp2 temp1 temp2;
quit;






/* if need labels removed (but missing values are coded as missing, so prob. OK) 
proc datasets lib=work memtype=data;
   modify t11;
     attrib _all_ label=' ';
     attrib _all_ format=;
quit;
proc contents data = t11;run;
*/
