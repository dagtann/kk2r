// PSID Equivalence file from CNEF
// -------------------------------
// kkstata@web.de

use $cnef07/pequiv_2007, clear

keep x11101ll x11102 d11104 d11106 d11107 d11109 e11101 e11103  ///
  i11101 i11102 i11110 

foreach var of varlist x11102-i11110 {
	gettoken first: var, parse("_")
	ren `var' `first'07
}
save pequiv07kk, replace

exit

