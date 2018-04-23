// State populations sizes
// -----------------------
// kkstata@web.de

version 12
insheet using $daus3/downloaded_data/gv.csv, clear

drop satzart textcode

ren land state
ren rb district
ren kreis county
ren gem community
ren name community_name
ren inhabitants pop_total
ren male pop_male
ren female pop_female
ren density pop_dens
ren plz zip

drop vb

generate state_name = "Schleswig-Holstein" if state == 1
replace state_name = "Hamburg" if state == 2
replace state_name = "Niedersachsen" if state == 3
replace state_name = "Bremen" if state == 4
replace state_name = "Nordrhein-Westfalen" if state == 5
replace state_name = "Hessen" if state == 6
replace state_name = "Rheinland-Pfalz" if state == 7
replace state_name = "Baden-Wuerttemberg" if state == 8
replace state_name = "Bayern" if state == 9
replace state_name = "Saarland" if state == 10
replace state_name = "Berlin" if state == 11
replace state_name = "Brandenburg" if state == 12
replace state_name = "Mecklenburg-Vorpommern" if state == 13
replace state_name = "Sachsen" if state == 14
replace state_name = "Sachsen-Anhalt" if state == 15
replace state_name = "Thueringen" if state == 16

label variable state "State (key)"	
label variable state_name "State (name)"
label variable district "District/Reg.-Bezirk"
label variable county "County/Landkreis (key)"
label variable community "Community (key)"
label variable community_name "Community (name)"
label variable zip "Zip code"
label variable area "Area in km^2"
label variable pop_total "Population"
label variable pop_male "Population (male)"
label variable pop_female "Population (female)"
label variable pop_dens "Population density"

keep if pop_male != .
keep if pop_total > 0

order state state_name district county community community_name zip ///
  area pop_total pop_male pop_female pop_dens

label data "German List of Communites 2009 (GV100AD)"
note: Statistisches Bundesamt; Data downloaded as file GV100311210_J.asc.
compress

collapse (sum) area pop_total pop_male pop_female , by(state_name)
generate pop_dens = pop_total/area

label variable state_name "State (name)"
label variable area "Area in km^2"
label variable pop_total "Population"
label variable pop_male "Population (male)"
label variable pop_female "Population (female)"
label variable pop_dens "Population density"
label data "Population 2009"

format %8.0f area-pop_dens

// Popst1
// ------

save popst1, replace
export excel using popst1.xls, replace firstrow(varlabels)  ///
  sheet("Absolute")

preserve
drop pop_dens
foreach var of varlist area pop_* {
	summarize `var', meanonly
	replace `var' = round(`var'/r(sum) * 100,1)
}

export excel using popst1.xls, sheetreplace firstrow(varlabels)  ///
  sheet("Percent")
restore

export sasxport popst1.xpt, replace rename

preserve
replace pop_total = . in 2
outsheet using popst1.raw, comma replace noquote nonames
restore

// Popst2
// ------

outsheet using popst2.raw, comma replace noquote

// Popst3
// ------

tempfile x
outfile using `x', replace noquote
filefilter `x' popst3.raw, replace ///
  from("Baden-Wuerttemberg")  ///
  to("Baden-Wuerttemberg \r")

// Popst4
// ------

replace state_name = "Mecklenburg Vorpommern"  ///
  if state_name == "Mecklenburg-Vorpommern"

outfile using popst4.raw, replace noquote

// Popst5
// ------

replace state_name = "Mecklenburg-Vorpommern"  ///
  if state_name == "Mecklenburg Vorpommern"

outsheet using popst5.raw, replace noquote nonames

file open popst5 using popst5kk.dct, replace write text
file write popst5  ///
  "dictionary using popst5.raw { " _n ///
	  "  state" _n       ///
	  "  area" _n        ///
	  "  pop_total" _n   ///
	  "  pop_male" _n    ///
	  "  pop_female" _n  ///
	  "  pop_dens" _n    ///
	" }" _n
file close popst5


// Popst6
// ------

file open popst6 using popst6.raw, replace write text
forv i = 1/`=_N' {
	file write popst6          ///
	  %22s (state[`i'])        ///
	  %5.0f (area[`i'])        ///
	  %8.0f (pop_total[`i'])   ///
	  %7.0f (pop_male[`i'])    ///
	  %7.0f (pop_female[`i'])  ///
	  %4.0f (pop_dens[`i'])  _n
	 } 
file close popst6

file open popst6 using popst6.dct, replace write text
file write popst6  ///
  `"dictionary using popst6.raw { "' _n ///
  `"  _column(1)  str22 state %22s "State (name)"   "'      _n  ///
  `"  _column(23) area         %5f "Area in km^2"   "'      _n  ///
  `"  _column(28) pop_total    %8f "Total Population"   "'  _n  ///
  `"  _column(36) pop_male     %7f "Male Population"    "'  _n  ///
  `"  _column(43) pop_female   %7f "Female Population"  "'  _n  ///
  `"  _column(50) pop_dens     %4f "Population Density" "'  _n  ///
  `"}"' _n
file close popst6


exit

