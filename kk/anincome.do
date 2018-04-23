// Table of nested models
// kkstata@web.de

version 12

capture which esttab
if _rc {
	net sj 7-2
	net install st0085_1
}

use data1, clear

generate men = sex==1
label var men "Men"

replace emp = . if emp==5

levelsof emp, local(K)
foreach k of local K {
	generate emp`k' = emp==`k' if !missing(emp)
	label variable emp`k' "`=proper("`:label (emp) `k''")'"
}

generate age = 2009 - ybirth

mark touse
markout touse men emp yedu age 

summarize age if touse, meanonly
replace age = age-r(mean)
label variable age "Age in Years"

summarize yedu if touse, meanonly
replace yedu = yedu - r(mean)
label variable yedu "Years of Education"

generate menage = men*age
label variable menage `"Men${\times}$Age"'

eststo clear
eststo: reg income men age if touse
eststo: reg income men age emp2 emp4 yedu if touse
eststo: reg income men age emp2 emp4 yedu menage if touse

esttab, r2 label obslast nomtitles tex se
exit
