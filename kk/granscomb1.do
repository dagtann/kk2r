* Scatterplots of Anscombe-Quartett

version 12
preserve
use anscombe, clear

forv i = 1/4 {

	graph twoway /// 
	  || lfit y`i' x`i' ///
	  || scatter y`i' x`i', mstyle(p1) /// 
	  || ,  name(g`i', replace) legend(off) ///
	  title(Y{subscript:`i'} on X{subscript:`i'}, pos(12) box bexpand)  ///
	  ytitle(Y{subscript:`i'}) ///
	  xtitle(X{subscript:`i'}) ///
	  nodraw
	
}

graph combine g1 g2 g3 g4

restore
exit



