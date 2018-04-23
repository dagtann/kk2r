// Create analwe.dta from data1.dta
version 12
preserve  
use data1, clear
collapse (mean) ybirth (count) n=ybirth [aweight=xweights], by(state)
label data "Example data with analytic weights"
save analwe, replace
restore

exit

