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
  d1110484 d1110485 d1110486 d1110487 d1110488 d1110489  ///
  d1110490 d1110491 d1110492 d1110493 d1110494 d1110495  ///
  d1110496 d1110497 d1110498 d1110499  ///
  d1110400 d1110401 d1110402 d1110403 d1110404 d1110405  ///
  d1110406 d1110407 d1110408 d1110409  ///
  d1110684 d1110685 d1110686 d1110687 d1110688 d1110689  ///
  d1110690 d1110691 d1110692 d1110693 d1110694 d1110695  ///
  d1110696 d1110697 d1110698 d1110699  ///
  d1110600 d1110601 d1110602 d1110603 d1110604 d1110605  ///
  d1110606 d1110607 d1110608 d1110609  ///
  d1110784 d1110785 d1110786 d1110787 d1110788 d1110789  ///
  d1110790 d1110791 d1110792 d1110793 d1110794 d1110795  ///
  d1110796 d1110797 d1110798 d1110799  ///
  d1110700 d1110701 d1110702 d1110703 d1110704 d1110705  ///
  d1110706 d1110707 d1110708 d1110709  ///
  d1110984 d1110985 d1110986 d1110987 d1110988 d1110989  ///
  d1110990 d1110991 d1110992 d1110993 d1110994 d1110995  ///
  d1110996 d1110997 d1110998 d1110999  ///
  d1110900 d1110901 d1110902 d1110903 d1110904 d1110905  ///
  d1110906 d1110907 d1110908 d1110909  ///
  e1110184 e1110185 e1110186 e1110187 e1110188 e1110189  ///
  e1110190 e1110191 e1110192 e1110193 e1110194 e1110195  ///
  e1110196 e1110197 e1110198 e1110199  ///
  e1110100 e1110101 e1110102 e1110103 e1110104 e1110105  ///
  e1110106 e1110107 e1110108 e1110109  ///
  e1110384 e1110385 e1110386 e1110387 e1110388 e1110389  ///
  e1110390 e1110391 e1110392 e1110393 e1110394 e1110395  ///
  e1110396 e1110397 e1110398 e1110399  ///
  e1110300 e1110301 e1110302 e1110303 e1110304 e1110305  ///
  e1110306 e1110307 e1110308 e1110309  ///
  i1110184 i1110185 i1110186 i1110187 i1110188 i1110189  ///
  i1110190 i1110191 i1110192 i1110193 i1110194 i1110195  ///
  i1110196 i1110197 i1110198 i1110199  ///
  i1110100 i1110101 i1110102 i1110103 i1110104 i1110105  ///
  i1110106 i1110107 i1110108 i1110109  ///
  i1110284 i1110285 i1110286 i1110287 i1110288 i1110289  ///
  i1110290 i1110291 i1110292 i1110293 i1110294 i1110295  ///
  i1110296 i1110297 i1110298 i1110299  ///
  i1110200 i1110201 i1110202 i1110203 i1110204 i1110205  ///
  i1110206 i1110207 i1110208 i1110209  ///
  i1111084 i1111085 i1111086 i1111087 i1111088 i1111089  ///
  i1111090 i1111091 i1111092 i1111093 i1111094 i1111095  ///
  i1111096 i1111097 i1111098 i1111099  ///
  i1111000 i1111001 i1111002 i1111003 i1111004 i1111005  ///
  i1111006 i1111007 i1111008 i1111009  ///
  using $soep26 ///
  , ftyp(pequiv) waves(1984/2009) design(any) 

soepadd  ///
  abula bbula cbula dbula ebula fbula gbula hbula ibula jbula kbula ///
  lbula mbula nbula obula pbula qbula rbula sbula tbula ubula vbula ///
  wbula xbula ybula zbula ///
  , waves(1984/2009) ftyp(hbrutto)

soepadd  ///
  ap5601 bp7901 cp7901 dp8801 ep7701 fp9301 gp8501 ///
  hp9001 ip9001 jp9001 kp9201 lp9801 mp8401 np9401 ///
  op9701 pp111 qp116 rp111 sp111 tp118 up123 ///
  vp129 wp119 xp128 yp130 zp123 ///
  ap5602 bp7902 cp7902 dp8802 ep7702 fp9302 gp8502 ///
  hp9002 ip9002 jp9002 kp9202 lp9802 mp8402 np9402 ///
  op9702 pp11201 qp11701 rp112 sp11201 tp11901 up12401 vp13001 ///
  wp12001 xp12901 yp13101 zp12401 ///
  ap5603 bp7903 cp7903 dp8803 ep7703 fp9303 gp8503 ///
  hp9003 ip9003 jp9003 kp9203 lp9803 mp8403 np9403 ///
  op9703 pp11202 qp11702 rp113 sp11202 tp11902 up12402 vp13002 ///
  wp12002 xp12902 yp13102 zp12402 ///
  ap6801 bp9301 cp9601 dp9801 ep89 fp108 gp109 ///
  hp10901 ip10901 jp10901 kp10401 lp10401 mp11001 np11701 ///
  op12301 pp13501 qp14301 rp13501 sp13501 tp14201 up14501 vp154 ///
  wp142 xp149 yp15501 zp15701  ///
  , waves(1984/2009) ftyp(p)

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

// hhnrakt
generate ahhnr_n = hhnr_n
foreach Y in b c d e f g h i j k l m n o p q r s t u v w x y z  {
	generate `Y'hhnr_n = ahhnr_n if `Y'hhnr==`L'hhnr
	bysort `Y'hhnr (r): replace tag = (1 - (_n==1)) | (`Y'hhnr==`L'hhnr)
	sort tag r
	replace `Y'hhnr_n = `maxhhnr_n'  ///
	  + int(_n * 50) + int(rnormal(0,10)) if !tag
	bysort tag `Y'hhnr_n (r): assert _N==1 if !tag
	by `Y'hhnr (`Y'hhnr_n r), sort: replace `Y'hhnr_n = `Y'hhnr_n[1]
	local L `Y'
}

// Anonnymize Income
// -----------------

unab hhpost: i11101*
unab hhpre: i11102*
unab earnings: i11110*
unab hhnr: ?hhnr
sort persnr
foreach list in hhpost hhpre earnings {
	tokenize `hhnr'
	foreach var of local `list'  {
		replace `var' =  ///
		  cond(`var' <= 100,  ///
		  round(`var' + rnormal(0,`var'/10)) , ///
		  round(`var' + rnormal(0,100))) ///
		  if `var' > 0 & `var' < .
		
		_pctile `var' if `var'>0, percentiles(99)
		local y = r(r1)
		_pctile `var' if `var'>= `y', percentiles(50)
		replace `var' = round(r(r1) + rnormal(0,100)) if `var' >=`y'
		note `var': Top 1% is random value around Median of top 1 percent
		replace `var' = . if `var'<0
		by `1' (persnr), sort: replace `var' = `var'[1]
		macro shift
	}
}

// Merge East and West-Berlin
// --------------------------

foreach Y in `c(alpha)' {
	replace `Y'bula = 0 if `Y'bula==11
}

// Saving
// ------

// Prepare for Saving
replace persnr=persnr_n
replace hhnr=hhnr_n

foreach stub in `c(alpha)' {
	replace `stub'hhnr = `stub'hhnr_n
}
compress


// ppfad
preserve
keep hhnr persnr ?hhnr ?netto
compress
save kksoep/ppfad, replace

// P-files
restore, preserve
foreach stub in `c(alpha)' {
	keep if inrange(`stub'netto,10,19)
	keep hhnr persnr `stub'hhnr `stub'p*
	save kksoep/`stub'p, replace
	restore, preserve
}

// Equiv-files
tokenize `c(alpha)'
foreach stub in 84 85 86 87 88 89 90 91 92 93 94 95 96 97  ///
  98 99 00 01 02 03 04 05 06 07 08 09  {
	keep if inrange(`1'netto,10,19)
	keep hhnr persnr `1'hhnr d111*`stub' i111*`stub' e111*`stub' 
	save kksoep/`1'pequiv, replace
	macro shift
	restore, preserve
}

// Hbrutto
foreach stub in `c(alpha)' {
	by `stub'hhnr, sort: generate x = inrange(`stub'netto,10,19)
	by `stub'hhnr (x), sort: keep if _n==_N & x 
	keep hhnr `stub'hhnr `stub'bula 
	save kksoep/`stub'hbrutto, replace
	restore, preserve
}


exit
