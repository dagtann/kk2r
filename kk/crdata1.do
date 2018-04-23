// Creates main example file for Data analysis using Stata
// -------------------------------------------------------
// kohler@wzb.eu, thewes@wzb.eu

// Intro
// -----

version 12
capture which soepuse
if _rc ssc install soepuse
clear

// Retrival
// --------

soepuse /// 
  zp0107 ///
  zp12801 zp12802 zp12803 zp12804 zp12805 zp12806 ///
  zp12807 zp12808 zp12809 zp12810 zp12811 zp12812 ///
  zp122 zp123 zp12401 zp12402  ///
  using $soep26 ///
  , ftyp(p) waves(2009) keep(sex gebjahr) design(any)

soepadd ///
  cnstyr09 seval09 size09 room09 ///
  eqphea09 eqpter09 eqpbas09  ///
  eqpgar09 eqpalm09 eqpsol09 eqpair09  ///
  eqplif09 eqpnrj09               ///
  condit09 rent09 reval09 moveyr09 typ1hh09 owner09 ///
  , ftyp(hgen) waves(2009)

soepadd zwum1 zwum3 , ftyp(hbrutto) waves(2009)

soepadd ///
  d1110409 d1110509 d1110609 d1110909 ///
  i1110209 i1111009  ///
  l1110109  ///
  h1110109  ///
  m1112509 m1112609 m1112709  /// ///
  w1110109 ///
  p1110109, ftyp(pequiv) waves(2009) 

soepadd  ///
  egp09 emplst09 zpsbil zpbbil01 zpbbil02 zpbbil03 ///
     , ftyp(pgen) waves(2009)

merge m:1 hhnr using $soep26/design ///
  , keepusing(rgroup ksample design strat psu intnr) keep(3) nogen

keep if inrange(znetto,10,19)

// Teaching data set
// -----------------

local full = _N
keep if inrange(rgroup,5,8)       // Teaching data set
drop if rgroup==5                 // Reduce a bit more to save space
drop rgroup
drop if inlist(ksample,5,7,8,9) // We don't use Incentive and High-Income

local reduced = _N/`full'
di `reduced'

//  Program to rename variables and store original name
//  ---------------------------------------------------

capture program drop umben
program umben
	ren `1' `2'
	note `2': Official SOEP name: `1'
	if "`3'" != "" label variable `2' "`3'"
end


capture program drop cleanlabel
program cleanlabel
	local lname: value label `1'
	levelsof `1', local(K)
	foreach k of local K {
		local oldlab: label (`1') `k'
		local newlab: subinstr local oldlab "`k'" "", all
		local newlab: subinstr local newlab "[]" "", all
		local newlab = trim("`newlab'")
		label define `1' `k' "`newlab'", modify
	}
	label value `1' `1'
end

// Define frequently used variable labels
// --------------------------------------

label define scale11 ///
  0 "Completely dissatisfied"  ///
  5 "Intermediate" ///
  10 "Completely satisfied"

label define scale2 ///
  1 "Yes" ///
  2 "No"

label define much4 ///
  1 "Very much" ///
  2 "Much" ///
  3 "Not much" ///
  4 "Not at all"

label define strong5 ///
  1 "Very strong" ///
  2 "Strong" ///
  3 "Moderate" ///
  4 "Fairly weak" ///
  5 "Very weak"

label define concern3 ///
  1 "Very concerned" ///
  2 "Somewhat concerned" ///
  3 "Not concerned at all"


// Set varnames, value labels and variable labels
// ----------------------------------------------

label variable persnr "Never changing person ID"
label variable hhnr "Origial household number"

label variable sex "Gender"
lab def sex 1 "Male" 2 "Female", modify

umben gebjahr ybirth "Year of birth" 

umben zhhnr hhnr2009 "Current household number"

umben zp0107 dsat
label variable dsat "Satisfaction with dwelling"
label value dsat scale11

umben zp122 polint "Political Interests"
label value polint much4

umben zp123 pia "Supports political party"
label value pia scale2

generate pib:pib = 1 if zp12401 == 1
replace pib = 2 if inlist(zp12401,2,3,13)
replace pib = 3 if zp12401==4
replace pib = 4 if zp12401==5
replace pib = 5 if zp12401==6
replace pib = 6 if zp12401==7
replace pib = 7 if zp12401==8
replace pib = 8 if inlist(zp12401,10,11,14,15,16,21,22,23)
label variable pib "Political party supported"
label define pib ///
  1 "SPD" ///
  2 "CDU/CSU" ///
  3 "FDP" ///
  4 "Greens/B90" ///
  5 "Linke" ///
  6 "DVU, Rep., NPD"  ///
  7 "Other parties" ///
  8 "Several parties"
drop zp12401

umben zp12402 pic "Amount of support for political party"
label value pic strong5

umben zp12801 wor01 "Worried about economic development"
umben zp12802 wor02 "Worried about finances"
umben zp12803 wor03 "Worried about stability of financial markets"
umben zp12804 wor04 "Worried about own health"
umben zp12805 wor05 "Worried about environment"
umben zp12806 wor06 "Worried about consequences from climate change"
umben zp12807 wor07 "Worried about peace"
umben zp12808 wor08 "Worried about global terrorism "
umben zp12809 wor09 "Worried about crime in Germany"
umben zp12810 wor10 "Worried about immigration to Germany"
umben zp12811 wor11 "Worried about hostility to foreigners"
umben zp12812 wor12 "Worried about job security"
foreach var of varlist wor* {
	label value `var' concern3
}

umben moveyr09 ymove "Year moved into dwelling"

umben cnstyr09 ybuild "Year house was build"
label define ybuild  ///
  1 "< 1918" ///
  2 "1918--1948" ///
  3 "1949--1971" ///
  4 "1972--1980" ///
  5 "1981--1990" ///
  6 "1991--2000" ///
  7 "2001 or later"
label value ybuild ybuild

umben condit09 condit "Condition of house"
label define condit  ///
  1 "In good condition" ///
  2 "Partial renovation"  ///
  3 "Major renovation" ///
  4 "Ready for demolition"
label value condit condit

umben seval09 seval "Adequacy of living space in housing unit"
label define seval  ///
  1 "Much too small" ///
  2 "A bit too small" ///
  3 "Just right" ///
  4 "A bit too large" ///
  5 "Much too large"
label value seval seval

umben eqphea09 eqphea "Dwelling has central floor head"
umben eqpter09 eqpter "Dwelling has balcony/terrace"
umben eqpbas09 eqpbas "Dwelling has basement"
umben eqpgar09 eqpgar "Dwelling has garden"
umben eqpalm09 eqpalm "Dwelling has alarm system"
umben eqpsol09 eqpsol "Dwelling has solar system"
umben eqpair09 eqpair "Dwelling has air conditioner"
umben eqplif09 eqplif "Dwelling has elevator"
umben eqpnrj09 eqpnrj "Dwelling has alternative energy source"
foreach var of varlist eqp* {
	label value `var' scale2
}

umben size09 size  "Size of housing unit in ft.^2"
replace size = round(size * 10.76391,1) if size

umben room09 rooms  "Number of rooms larger than 65 ft.^2"

umben rent09 rent  "Rent minus heating costs in USD"
replace rent = rent/0.78 if rent > 0 // Big Mac Index, 21 Juli 2010

umben reval09 reval "Adequacy of rent"
label define reval  ///
  1 "Very cheap" ///
  2 "Cheap" ///
  3 "Adequate" ///
  4 "Too expensive" ///
  5 "Much too expensive"
label value reval reval

umben owner09 renttype "Status of living"
label define renttype  ///
  1 "Owner" ///
  2 "Main tenant" ///
  3 "Subtenant" ///
  5 "Residential home"
label value renttype renttype

umben typ1hh09 hhtyp "Household typology"
label define hhtyp  ///
1 "1-Pers.-HH"  ///
  2 "Couple without children" ///
  3 "Single parent" ///
  4 "Couple with children <= 16" ///
  5 "Couple with children > 16" ///
  6 "Couple with children <= 16 and > 16" ///
  7 "Multiple generation HH" ///
  8 "Other combination"
label value hhtyp hhtyp

umben zwum1 area1 "Residental area: type of house"
label define area1 ///
  1 "Farm House" ///
  2 "1-2 Fam. House" ///
  3 "1-2 Fam. Rowhouse" ///
  4 "Apt. In 3-4 Unit Bldg." ///
  5 "Apt. In 5-8 Unit Bldg." ///
  6 "Apt. In 9+ Unit Bldg." ///
  7 "High Rise" ///
  8 "Other Building" 
label value area1 area1

umben zwum3 area2 "Residental area: Rental Housing"
label define area2 ///
  1 "Res. Area Old." ///
  2 "Res. Area New." ///
  3 "Mixed Resid., Comm Area" ///
  4 "Commercial Area" ///
  5 "Industrial Area" ///
  6 "Other"
label value area2 area2

umben d1110409 mar
cleanlabel mar

umben d1110509 rel2head
cleanlabel rel2head

umben d1110609 hhsize
umben d1110909 yedu
umben i1110209 hhinc
umben i1111009 income
umben h1110109 hhsize0to14

umben l1110109 state
cleanlabel state

umben m1112509 hsat
label value hsat scale11

umben m1112609 heval
cleanlabel heval

umben m1112709 dvisits

umben p1110109 lsat
label value lsat scale11

umben emplst09 emp "Status of Employment"
label define emp  ///
  1 "full time" ///
  2 "part time" ///
  3 "retraining" ///
  4 "irregular"  ///
  5 "not employed"  ///
  6 "sheltered workshop" 
label value emp emp

umben egp09 egp "Social Class (EGP)"
label define egp  ///
1 "Service class 1" ///
2 "Service class 2" ///
3 "Higher routine non-manuals" ///
4 "Lower routine non-manuals" ///
5 "Large proprietors (> 10 employees)" ///
6 "Small proprietors (< 10 employees)" ///
8 "Skilled manual workers" ///
9 "Semi- and unskilled manual workers" ///
10 "Farm worker" ///
11 "Farmers" ///
15 "unemployed" ///
18 "Retired"
label value egp egp

umben zpsbil edu "Education"
label define edu ///
  1 "Elementary" ///
  2 "Intermediate"  ///
  3 `""Fachhochschulreife""' ///
  4 "Maturity qualification" ///
  5 "Other" ///
  6 "Not completed" ///
  7 "Still in school"
label value edu edu

generate voc = zpbbil02 + 6 if zpbbil02 > 0
replace voc = zpbbil02 if zpbbil02 < 0
replace voc = zpbbil01 if voc < 0
recode voc 1=1 2/3=2 4/5=3 6=4 7 10 11 =5 8 9 12=6   ///
  if voc > 0
label variable voc "Vocational trainig/university"
label value voc voc
label define voc  ///
  1 "Vocational training" ///
  2 "Vocational training at collage" ///
  3 "Specified collage/Civil servant training"  ///
  4 "Other vocational training" ///
  5 "Proffessional collage" ///
  6 "University degree"
drop zpbbil*

ren design dweight
label variable dweight "Design weights"

ren strat strata
label variable strata "Strata"

ren ksample sample
label variable sample "Subsample identifier"
label define sample  ///
  1 "A (West Germany)" ///
  2 "B (Foreigner)" ///
  3 "C (East Germany)" ///
  4 "D (Immigrant)" ///
  5 "E (Refreshment)" ///
  6 "F (Innovation)"  ///
  7 "G (High income)" ///
  8 "H (Refreshment)" ///
  9 "I (Incentivization)" 
label value sample sample

label variable psu "Primary sampling units"

label variable intnr "Interviewer number"
label value intnr intnr

umben w1110109 xweights "Cross sectional weights"

// Anonymizing
// -----------

set seed 741967

// Merge PSUs with less than 10 observations
generate double r = runiform()

bysort psu (r): generate N = _N
count if N <= 10
xtile newpsu = psu if N<=10, nquantiles(`=int(r(N)/10)')
bysort newpsu (r): replace psu = psu[1] if N<=10
drop N newpsu

// Create fictious Identifiers for hhnr, hhnr2009 and persnr
bysort hhnr (r): generate tag = 1 - (_n==1)
sort tag r
generate long hhnr_n = int(_n * 50) + int(rnormal(0,10)) if !tag
bysort hhnr_n (r): assert _N==1 if !tag
by hhnr (hhnr_n r), sort: replace hhnr_n = hhnr_n[1]

summarize hhnr_n, meanonly
local maxhhnr_n = r(max)

generate long hhnr2009_n = hhnr_n if hhnr2009==hhnr
bysort hhnr2009 (r): replace tag = (1 - (_n==1)) | (hhnr2009==hhnr)
sort tag r
replace hhnr2009_n = `maxhhnr_n'  ///
  + int(_n * 50) + int(rnormal(0,10)) if !tag
bysort tag hhnr2009_n (r): assert _N==1 if !tag
by hhnr2009 (hhnr2009_n r), sort: replace hhnr2009_n = hhnr2009_n[1]

bysort hhnr_n (r): generate long persnr_n = (hhnr_n*100)+_n

replace persnr=persnr_n
replace hhnr=hhnr_n
replace hhnr2009=hhnr2009_n

drop hhnr_n hhnr2009_n persnr_n tag r 

// Create fictious Interviewer number
generate intnr_n = _n*10 + int(rnormal()) 
bysort intnr (persnr): replace intnr = intnr_n[1] if intnr > 0
drop intnr_n

// Add random noise to Income and Household income
sort persnr
foreach var of varlist income hhinc {
	summarize `var', meanonly
	local max = r(max)
	replace `var' =  ///
	  cond(`var' <= 100,  ///
	  round(`var' + rnormal(0,`var'/10)) , ///
	  round(`var' + rnormal(0,100))) ///
	  if `var' > 0 & `var' < .
	_pctile `var' if `var'>0, percentiles(99)
	replace `var' = round(r(r1) + rbeta(.5,2) * (`max'-r(r1))) 	/// 
	  if `var' > r(r1) & !missing(`var')
	note `var': Top 1% is random value around Median of top 1 percent
}
replace income = . if income < 0
replace hhinc  = . if hhinc <= 0

by hhnr2009 (persnr), sort: replace hhinc = hhinc[1]

summarize income, meanonly
assert r(sum)==99527026

// Add random noise +/- 1 year to year of birth
replace ybirth = ybirth + int(runiform()*3) -2 if  /// 
  ybirth < 1992 & runiform()>.5

// Add random noise to monthly rent 
replace rent = round(rent+rnormal(0,10),1) if rent>0 

// Add random noise to Flatsize
replace size = round(size+rnormal(0,3),1) if size > 0

// Concatenate State
replace state = 0 if state == 11
replace state = 2 if state == 4
lab def state 0 "Berlin" 2 "Hamburg/Bremen" 11 "" 4 "", modify

// Concatenate Household size
_pctile hhsize if hhsize >= 5, p(50)
replace hhsize = r(r1) if hhsize >= 5

// Concatenate Persons below 14 in Household
_pctile hhsize0to14 if hhsize0to14 >= 3, p(50)
replace hhsize0to14 = r(r1) if hhsize0to14>=3

// Concatenate Education
replace edu = 5 if inlist(edu,6,7)
lab def edu 6 "" 7 "", modify

// Concatenate Years of Education
summarize yedu if inlist(yedu,7,8,9), meanonly
local x1 = round(r(mean),.1)
summarize yedu if inlist(yedu,16,17), meanonly
local x2 = round(r(mean),.1)
replace yedu = int(yedu)
replace yedu = `x1' if inlist(yedu,7,8,9) 
replace yedu = `x2' if inlist(yedu,16,17)

// Concatenate Employment Status
replace emp = . if inlist(emp,3,6,.a,.b,.c)
lab def emp 3 "" 6 "Other", modify

// Concatenate EGP-Classes
replace egp = 5 if inlist(egp,5,6,11)
replace egp = 9 if egp == 10
lab def egp 5 "Self-Employed" 6 "" 10 "" 11 "", modify

// Concatenate Household type
replace hhtyp = 8 if hhtyp == 7
lab def hhtyp 7 "", modify

// Move some observations into other categories
generate movesome = inlist(hhsize0to14,1,2) & state==12 
sort movesome hhsize0to14 xweight
replace hhsize0to14 = 3 in -2/-1

replace movesome = edu==4 & state==15
sort movesome xweight
replace edu = 3 in l 

replace movesome = yedu==13 & state==12
sort movesome xweight
replace yedu = 14 in l

replace movesome = voc==1 & state==15
sort movesome xweight
replace voc = 4 in l

replace movesome = hhtyp==5 & state==15
sort movesome xweight
replace hhtyp = 8 in l

// Missing Values
// --------------
mvdecode _all, mv(-3=.c \ -2 = .b \ -1 = .a)

foreach var of varlist _all {
	local label: value label `var'
	if "`label'" != "" {
		label define `label'  ///
		  .a "Refusal"  ///
		  .b "Does not apply"  ///
		  .c "Inconsistent" , modify
	}
}
 

// End matters
// -----------

// Rescale weights
replace dweight = dweight * 1/`reduced'
replace xweight = xweight * 1/`reduced'

drop znetto movesome

order ///
  persnr hhnr2009 state ybirth sex mar edu yedu voc  ///
  emp egp income hhinc  ///
  hhsize hhsize0to14 rel2head ///
  ymove ybuild condit dsat size seval rooms renttype  ///
  rent reval eqp* hhtyp area*  ///
  dvisits heval hsat  /// 
  polint pia pib pic  ///
  lsat wor* ///
  sample intnr hhnr strata psu dweight xweight

label data "SOEP 2009 (Kohler/Kreuter)"

drop if dweight==0 | xweight==0

compress
sort persnr

// Add some didacting features
replace income = . if inlist(persnr, 8501, 8502)
replace income = . if income == 0 & runiform()< .3

save data1, replace

// Assert class sizes
// -------------------
// (by thewes@wzb.eu)

// If this runs without notification, each group has more than 5000 observations

foreach byvar of varlist sex state {
	foreach checkvar of varlist edu yedu voc emp egp hhtyp hhsize  /// 
	  hhsize0to14 ybuild  {
		quietly levelsof `byvar', local(bylevels)
		foreach bylevel of local bylevels {
			quietly levelsof `checkvar', local(checklevels)
			foreach checklevel of local checklevels {
				summarize `checkvar' [aweight=xweight] 	/// 
				  if `byvar' == `bylevel'  /// 
				  & `checkvar' == `checklevel', meanonly 
				capture assert r(sum_w) >= 5000 | r(sum_w)==0
				if _rc {
					di _n				///
					  "{res}`checkvar'{txt}=={res}`=round(`checklevel',.1)'{txt}" /// 
					  " has {res}`=round(`r(sum_w)',.1)'{txt} weighted obs for "  /// 
					  "{res}`byvar'{txt}=={res}`bylevel'"
				}
				
			}
		}
	}
}

exit


