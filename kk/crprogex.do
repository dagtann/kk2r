// Example files of GSOEP database
// -------------------------------
// kkstata@web.de

version 12
clear
set more off 

capture mkdir kksoep

// Retrive data
// ------------

soepuse  ///
  ap6801 bp9301 cp9601 dp9801 ep89 fp108 gp109 ///
  hp10901 ip10901 jp10901 kp10401 lp10401 mp11001 np11701 ///
  op12301 pp13501 qp14301 rp13501 sp13501 tp14201 up14501 vp154 ///
  wp142 xp149 yp15501 zp15701  ///
  using $soep26 ///
  , ftyp(p) waves(1984/2009) keep(gebjahr)

merge m:1 hhnr using $soep26/design ///
  , keepusing(rgroup ksample) keep(3) nogen

// Subsample of dataset
// --------------------

local full = _N
keep if inlist(rgroup,3,4,5)   // 3 Random Groups, no overlap with data1
drop if inlist(ksample,5,7,8,9) // Drop some samples

drop rgroup ksample

// Anonymize Identifiers
// ---------------------

set seed 29071970
generate r = runiform()

// HHNR
bysort hhnr (r): generate tag = 1 - (_n==1)
sort tag r
generate hhnr_n = int(_n * 50) + int(rnormal(0,10)) if !tag
bysort hhnr_n (r): assert _N==1 if !tag
by hhnr (hhnr_n r), sort: replace hhnr_n = hhnr_n[1]

summarize hhnr_n, meanonly
local maxhhnr_n = r(max)

// Persnr
bysort hhnr_n (r): generate long persnr_n = (hhnr_n*100)+_n


// Saving
// ------

ren gebjahr ybirth

// Prepare for Saving
replace persnr=persnr_n
replace hhnr=hhnr_n

keep hhnr persnr ybirth ap6801-zp15701

compress
save progex, replace

exit
