// Add fictious Age-Groups to titanic.dta
// kkstata@web.de

version 12
set seed 741967
set more off

// Download data
// -------------

clear

infile class adult men survived  ///
  using http://www.amstat.org/publications/jse/datasets/titanic.dat

label variable class "Class of passenger"
label variable adult "Adult passenger y/n"
label variable men "Male passenger y/n"
label variable survived "Passenger survived y/n"

label define class 0 "Crew" 1 "First" 2 "Second" 3 "Third"
label define yesno 0 "No" 1 "Yes"

label value class class
foreach var of varlist adult-survived {
	label value `var' yesno
}


// Create fictious age
// -------------------

// Children: Skewed left between 0 und 15
generate age = floor(rbeta(2,.5)*15) if !adult

// Adults: Skewed right; larger std.dev for not survived
replace age = 15 + floor(rbeta(1,4)*80) if adult & survived
replace age = 15 + floor(rbeta(3,5)*80) if adult & !survived

label variable age "Age in years (fictious)"
notes age: Variable created in crtitanic2.do


// End matter
// ----------

keep men class age survived
order men class age survived
compress

label data "Death Rates for an Unusual Episode (Dawson 1995) with fictious age"
note: Orginal data downloaded from http://www.amstat.org/publications/jse/datasets/titanic.dat

save titanic2, replace
exit

