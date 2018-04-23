// Create Titanic data set
// -----------------------
// kkstata@web.de

version 12
set more off
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

label data "Death Rates for an Unusual Episode (Dawson 1995)"
note: Data downloaded from http://www.amstat.org/publications/jse/datasets/titanic.dat

save titanic, replace

exit



