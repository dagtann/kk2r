// Show 100 confidence intervals
// kkstata@web.de

version 12
preserve
set seed 42

use ybirth using data1, clear

// Calculate mean in *population*
summarize ybirth, meanonly
local truemean = r(mean)

// Estimate 95% C.I. for samples of size 100
generate lb = .
generate ub = .
quietly forv i = 1/100 {
	mean ybirth if runiform() < (100/_N)
	replace lb = _b[ybirth] - 1.96 * _se[ybirth] in `i'
	replace ub = _b[ybirth] + 1.96 * _se[ybirth] in `i'
}

// An arbitrary Y axis
generate index = _n if _n <= 100

// Plot evertying
graph twoway 							/// 
  || rspike lb ub index 				/// 
  if !inrange(`truemean',lb,ub)  		 ///
  , horizontal lwidth(*1.5) lcolor(gs4) 	///
  || rspike lb ub index 				/// 
  if inrange(`truemean',lb,ub)  		 ///
  , horizontal lwidth(*1.5) lcolor(gs10) 	///
  || scatteri 101 `truemean' 0 `truemean', recast(line)  ///
  lpattern(solid) lcolor(black) 						///
  || scatteri 101 `truemean' `" Population average "'   ///
  , ms(i) mlabpos(12) 					///
  || , ysize(5) 						/// 
  xlabel(1952(2)1968)  ///
  ylabel(none) legend(off) yscale(off range(0 102)) scheme(s1mono) 	/// 
  plotregion(margin(zero) lstyle(none))

restore
exit
