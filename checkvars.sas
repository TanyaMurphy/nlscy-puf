
/* macro to generically check vars */
%macro checkvars (dsin = c1, dsout = c1p3);
proc contents data = &dsin out = temp1; run;
data temp2;set temp1 (keep = name label);
	length section $ 4;
	section = substr(name, 2, 3);
	if name NE 'CHILDID' then varname = substr(name, 2, length(name));
		else varname = name;
	if varname in (
'ACCQ1', 'ACCQ2AA', 'ACCQ2B', 
'BECS01', 'BECS02', 'BECS03', 'BECS04', 'BECS06', 'BECS07', 'BECS08', 'BECS09', 
'BECS10', 
'CHPQ1J', 'CHSQ1J', 
'CRCD01', 'CRCD02', 'CRCcQ2A', 'CRCD03', 'CRCD04', 'CRCD06', 'CRCQ04', 'CRCQ06', 'CRCQ07', 
'CRCQ1A', 'CRCcQ1A', 'CRCQ1B', 'CRCQ1BA', 'CRCbD01',
'CRCQ1BB', 'CRCQ1C', 'CRCQ1CA', 'CRCQ1CB', 'CRCQ1D', 'CRCQ1DA', 'CRCQ1E', 
'CRCQ1EA', 'CRCQ1F', 'CRCQ1FA', 'CRCQ1G', 'CRCQ1GA', 'CRCQ1GB', 'CRCQ1H',
 'CRCQ1HA', 'CRCQ1I', 'CRCcQ1I', 'CRCQ1IA', 'CRCQ1J', 'CRCcQ1J', 'CRCQ1JA', 'CRCc1JA', 
'CRCcQ1K', 'CRCc1KA', 
'DMCD03', 'DMCD04', 'DMCD04B', 'DMCD06', 'DMCD08', 'DMCD09', 'DMCD10', 'DMCD14', 'DMCD16', 
'DMCD18', 'DMCD18B', 'DMCD19', 'DMCD19B', 'DMCD20', 'DMCbD21', 'DMCbD22', 'DMCbD26', 
'DMHD06F', 
'DMPD06A', 'DMPD06D', 'DMPbD27', 'DMSD06E', 'DMSbD28', 'DPPS01', 
'EDCD01', 'EDCQ02', 'EDCQ03', 'EDCQ12B', 'EDCQ12C', 'EDCQ12D', 'EDCbQ0A',
'EDPD01', 'EDPD02', 'EDPQ02', 'EDPQ03', 'EDPQ05', 'EDPQ06', 
'EDSD01', 'EDSD02', 'EDSQ02', 'EDSQ03', 'EDSQ05', 'EDSQ06',
'ETCQ01', 'ETCS28A',  'ETCS28B', 'ETCS28C', 'ETCS28D', 'ETCS28E',
'FNHQ01M', 'FNHQ02', 'FNHS01', 
'GEHD03', 'GEHD01', 'GEHD02', 
'HHHQ02B', 'HHHQ06B', 'HHHD06B', 'HHHQ01', 'HHHQ02',
'HLCD02', 'HLCQ01', 'HLCQ02', 'HLCQ03B', 'HLCQ04A', 'HLCQ05', 'HLCQ31', 'HLCQ36',
'HLCQ37', 'HLCQ38', 'HLCQ39', 'HLCQ41', 'HLCQ42', 'HLCQ43B', 'HLCQ45L', 
'HLCQ46', 'HLCQ47A', 'HLCQ47B', 'HLCQ48A', 'HLCQ48B', 'HLCQ48C', 'HLCQ48D', 'HLCQ49', 
'HLCQ50', 'HLCQ51B', 'HLCQ52M', 
'HLPQ01', 'HLPQ02', 'HLPQ03', 'HLPQ04', 'HLPQ05', 'HLPcQ05', 'HLPcQ5A', 'HLPQ06', 
'HLSQ01', 'HLSQ02', 'HLSQ03', 'HLSQ04', 'HLSQ05', 'HLScQ05', 'HLScQ5A', 'HLSQ06', 
'IDHD01', 'CHILDID',
'INHD02B', 'INHD05', 'INHD05A', 'INHD07', 'INHD08', 'INHD08B',
'LFHD49', 'LFHD49B', 
'LFPD01A', 'LFPQ02', 'LFPD25', 'LFPD51', 
'LFSD01A', 'LFSQ02', 'LFSD25', 'LFSD51',
'MDCD01', 'MDCD02', 'MDCQ02', 'MDCD03', 'MDCD04', 'MDCD06', 'MDCD07', 'MDCD08', 'MDCD09', 
'MDCD10', 'MDCQ13B', 'MDCQ14B', 'MDCcD8A','MDCQ22', 'MDCQ25', 'MDCQ26', 'MDCQ27', 'MDCbQ29', 
'MMCQ01', 'MMCbD01', 'MMCQ02', 'MMCQ03A', 'MMCQ03B', 'MMCQ03C', 'MMPQ02', 'MMSQ02', 
'MSCS02', 'PPCD01', 'PPCS01', 
'PACS01', 'PACS02', 'PACS03', 'PACS04', 
'PRCQ26A', 'PRCQ26B', 'PRCQ26C', 'PRCQ26D', 'PRCQ26E', 'PRCQ26F', 'PRCQ26G', 
'PRCQ26H', 'PRCQ26I', 'PRCQ26J', 'PRCQ26K', 
'PRCS01', 'PRCS02', 'PRCS03', 'PRCS04', 'PRCS05', 'PRCS06', 
'RLCQ07', 'RLCQ08', 'RLCQ09', 'RSPD01', 'RSPQ01E', 'RSSD01', 'RSSQ01E', 
'SDPD02B', 'SDPD03', 'SDSD02B', 'SDSD03', 
'SFHQ01', 'SFHS6', 'SFHS7', 'SPHS01', 
'TMCQ25', 'TMCcQ25', 'TMCQ26', 'TMCcQ26','TMCQ27', 'TMCcQ27', 'TMCQ33',  
'WBCcQ1B', 'WBCcQ1C', 'WBCcQ02', 'WBCcQ2B', 'WBCcQ4A', 'WBCcQ4B', 'WBCcQ4C', 
'WTCW01', 'WTCW01C') 
		then keepit = 1;
	if section in ('A1C', 'B1C', 'C1C', 'D1C', 'E1C', 'F1C', 'G1C', 'H1C') 
		then keepit = 0;
run;
data &dsout;set temp2 (where = (keepit NE 0));run;
proc sort data = &dsout;by section varname;run;
%mend checkvars;

/* Get vars, check for equivalents that should be added to list in macro */
%checkvars(dsin = c1, dsout = c1p); * Cycle 1;
%checkvars(dsin = c2, dsout = c2p); * Cycle 2;
%checkvars(dsin = c3, dsout = c3p); * Cycle 3;
proc sql;
	create table c1pc2p as
	select coalesce(c1p.section, c2p.section) as section, 
		   coalesce(c1p.varname, c2p.varname) as varname, 
		   c1p.name as c1name, c1p.label as c1label, 
           c1p.keepit as c1keepit,
		   c2p.name as c2name, c2p.label as c2label, 
           c2p.keepit as c2keepit
	from work.c1p full outer join work.c2p
	on c1p.section = c2p.section and c1p.varname = c2p.varname;
quit;
proc sql;
	create table callp as
	select coalesce(c1pc2p.section, c3p.section) as section, 
		   coalesce(c1pc2p.varname, c3p.varname) as varname, 
		   c1pc2p.c1name, c1pc2p.c1label, c1pc2p.c1keepit,
		   c1pc2p.c2name, c1pc2p.c2label, c1pc2p.c2keepit,
		   c3p.name as c3name, c3p.label as c3label, 
           c3p.keepit as c3keepit
	from work.c1pc2p full outer join work.c3p
	on c1pc2p.section = c3p.section and c1pc2p.varname = c3p.varname;
quit;
data callp2;
	set callp (where = (c1keepit = 1 | c2keepit = 1 | c3keepit = 1 ));
run;
%ds2csv (data = callp2, runmode = b, csvfile = .\git-repos\nlscy-puf\vars.csv, labels = N);*/
