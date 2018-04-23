//  4 Verteilungen mit gleichem Mean und gleicher Standardabweichung

version 12
preserve

//  Create Data
//  ----------

clear
input x1
0 
2.5 
4 
5 
5.4 
5.6 
6 
7 
8.5 
11 
end

//  Store some results
summarize x1
local mean = r(mean)
local std = r(sd)

//  Variable 2
generate x2 = _n
egen z2 = std(x2)
replace x2 =  z2 * `std' + `mean' 
drop z2

//  Variable 3
generate x3 = x1 + x2^3
egen z3 = std(x3)
replace x3 = z3 * `std' + `mean'
drop z3

//  Variable 4
summarize x3, meanonly
generate x4 = r(max) + 1  - x3
egen z4 = std(x4)
replace x4 = z4 * `std' + `mean'
drop z4

//  Interchange rows and columns
xpose, clear

//  Generate an Idenifier
generate byte index=_n
lab var index "Variable"
lab val index index
lab def index 1 "Variable 1" 2 "Variable 2" 3 "Variable 3" 4 "Variable 4"

//  Collect marker options in a macro
forv i=1/10 {
	  local marker "`marker' m(`i', ms(O) mc(black))" 
}

//  Graphik
local a = `mean' - `std'
local b = `mean' 
local c = `mean' + `std'

graph dot v*, `marker' over(index) legend(off) ylabel(0(4)12)   ///
  yline(`a' `b' `c', lpattern(solid) noextend lwidth(vvthin)) 
restore

exit








