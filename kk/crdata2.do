// Longitudinal Data for  Kohler/Kreuter
// Creator kkstata@web.de

// Intro
// -----

version 12
capture which soepuse
if _rc ssc install seopuse
clear

// Retrival
// --------

soepuse ///
  d1110484 d1110485 d1110486 d1110487 d1110488 d1110489 d1110490  ///
  d1110491 d1110492 d1110493 d1110494 d1110495 d1110496 d1110497  ///
  d1110498 d1110499 d1110400 d1110401 d1110402 d1110403 d1110404  ///
  d1110405 d1110406 d1110407 d1110408 d1110409 ///
  e1110184 e1110185 e1110186 e1110187 e1110188 e1110189 e1110190  ///
  e1110191 e1110192 e1110193 e1110194 e1110195 e1110196 e1110197  ///
  e1110198 e1110199 e1110100 e1110101 e1110102 e1110103 e1110104  ///
  e1110105 e1110106 e1110107 e1110108 e1110109 ///	
  i1110284 i1110285 i1110286 i1110287 i1110288 i1110289 i1110290  ///
  i1110291 i1110292 i1110293 i1110294 i1110295 i1110296 i1110297  ///
  i1110298 i1110299 i1110200 i1110201 i1110202 i1110203 i1110204  ///
  i1110205 i1110206 i1110207 i1110208 i1110209 ///	
  p1110184 p1110185 p1110186 p1110187 p1110188 p1110189 p1110190  ///
  p1110191 p1110192 p1110193 p1110194 p1110195 p1110196 p1110197  ///
  p1110198 p1110199 p1110100 p1110101 p1110102 p1110103 p1110104  ///
  p1110105 p1110106 p1110107 p1110108 p1110109 ///	
  using $soep26 ///
  , ftyp(pequiv) waves(1984/2009) design(10) keep(sex gebjahr)

merge m:1 hhnr using $soep26/design ///
  , keepusing(rgroup ksample design strat psu intnr) keep(3) nogen

// Subsample of dataset
// --------------------

local full = _N
keep if inlist(rgroup,3,4,5)   // 3 Random Groups, no overlap with data1
drop if inlist(ksample,5,7,8,9) // Drop some samples

drop ?netto rgroup // We drop current household number downstream

local reduced = _N/`full'
di `reduced'

// Set varnames, value labels and variable labels
// ----------------------------------------------

label variable persnr "Never changing person ID"
label variable hhnr "Origial household number"

label variable sex "Gender"
lab def sex 1 "Male" 2 "Female", modify

ren gebjahr ybirth
label variable ybirth "Year of birth" 

soepren p11101??, newstub(lsat) waves(1984(1)2009)
foreach var of varlist lsat* {
	lab val `var' scale11
}
label define scale11 ///
  0 "Completely dissatisfied"  ///
  5 "Intermediate" ///
  10 "Completely satisfied"

soepren i11102??, newstub(hhinc) waves(1984(1)2009)
soepren e11101??, newstub(whours) waves(1984(1)2009)

soepren d11104??, newstub(mar) waves(1984(1)2009)
foreach var of varlist mar* {
	lab val `var' mar
}
label define mar ///
  1 "Married"  ///
  2 "Single" ///
  3 "Widowed" ///
  4 "Divorced" ///
  5 "Separated"


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

ren design dweight
label variable dweight "Design weights"

ren strat strata
label variable strata "Strata"

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

// Create fictious Identifiers for hhnr and persnr
bysort hhnr (r): generate tag = 1 - (_n==1)
sort tag r
generate long hhnr_n = int(_n * 50) + int(rnormal(0,10)) if !tag
bysort hhnr_n (r): assert _N==1 if !tag
by hhnr (hhnr_n r), sort: replace hhnr_n = hhnr_n[1]

summarize hhnr_n, meanonly
local maxhhnr_n = r(max)

bysort hhnr_n (r): generate long persnr_n = (hhnr_n*100)+_n

replace persnr=persnr_n
replace hhnr=hhnr_n
drop hhnr_n persnr_n tag r 

// Create fictious Interviewer number
generate intnr_n = _n*10 + int(rnormal()) 
bysort intnr: replace intnr = intnr_n[1]
drop intnr_n

// Add random noise to Household income
soepren ?hhnr, newstub(hnr) waves(1984(1)2009)
sort persnr
forv year=1984(1)2009 {
	replace hhinc`year' =  ///
	  cond(hhinc`year' <= 100,  ///
	  round(hhinc`year' + rnormal(0,hhinc`year'/10)) , ///
	  round(hhinc`year' + rnormal(0,100))) ///
	  if hhinc`year' > 0 & hhinc`year' < .

	_pctile hhinc`year' if hhinc`year'>0, percentiles(99)
	local y = r(r1)
	_pctile hhinc`year' if hhinc`year'>= `y', percentiles(50)
	replace hhinc`year' = round(r(r1) + rnormal(0,100)) if hhinc`year' >=`y'
	note hhinc`year': Top 1% is random value around Median of top 1 percent
	replace hhinc`year' = . if hhinc`year'<0
	by hnr`year' (persnr), sort: replace hhinc`year' = hhinc`year'[1]
}
drop hnr*


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

order ///
  persnr hhnr sex ybirth mar* hhinc* whours* lsat*  ///
  sample intnr hhnr strata psu dweight 

label data "SOEP 1984-2009 (Kohler/Kreuter)"

drop if dweight==0 

compress
sort hhnr persnr

save data2w, replace


// Create data2agg
keep persnr lsat* hhinc* dweight

reshape long lsat hhinc, i(persnr) j(wave)
collapse lsat hhinc [aw=dweight], by(wave)
format %2.1f lsat


drop if wave == 2009 // otherwise qreg-example does not play throug

label data "Mean life satisfaction 1984-2008 (Kohler/Kreuter)"
label variable wave "Year"
label variable  lsat "Mean life satisfaction"
label variable hhinc "Mean household income"

save data2agg, replace

exit
	
	
