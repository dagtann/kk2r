// Examples for Leverage und Diskrepancy of the Beatles and St. Pepper
// kkstata@web.de
version 12

preserve

// Create the Data
clear
input str11 name flatsize1965  income1965
	Ringo              50       2000
	George             60       2300
	John               70       2800
	Paul               80       3000
	"Sgt. Pepper"      80       2525
end

generate income1967 = income1965
replace income1967 = 3400 in 5
reg flatsize1965 income1967 in 1/4
predict flatsize1967
generate income1971 = income1967
generate flatsize1971 = flatsize1967
replace flatsize1971 = 68 in 5

// Run Regressions
foreach i in 1965 1967 1971 {

	reg flatsize`i' income`i'
	predict yh1`i'
	reg flatsize`i' income`i' in 1/4
	predict yh2`i'
}

// Reshape
reshape long flatsize income yh1 yh2, i(name) j(year)

graph twoway ///
  || scatter flatsize income, mlabel(name) ///
  || line yh1 yh2 income, sort ///
  || , by(year, legend(off) note("") rows(3))  ///
  ytitle(Flat size) xtitle(Income)


restore
