// Frequency weighted data

preserve  
use data1, clear
contract ybirth, freq(n) 
label data "Frequency weighted data from data1.dta"
save freqwe, replace
restore

exit
