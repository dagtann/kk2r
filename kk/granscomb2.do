* Residual vs. fitted plots of Anscombe-Quartetts

version 12
preserve
use anscombe, clear

forv i = 1/4 {

	reg y`i' x`i'
	rvfplot  ///
	  , title(RvF-Plot of Y{subscript:`i'} on X{subscript:`i'}, pos(12) box bexpand)  ///
	  ytitle(Residual of Y{subscript:`i'} on X{subscript:`i'}) ///
	  xtitle(Fitted value) ///
	  nodraw name(g`i', replace)
	
}

graph combine g1 g2 g3 g4

restore
exit
















reg y1 x1
rvfplot, name(g1b, replace)
	
reg y2 x2
rvfplot, name(g2b, replace)

reg y3 x2
rvfplot, name(g3b, replace)

reg y4 x4
rvfplot, name(g4b, replace) 

graph combine g1b g2b g3b g4b

restore
exit
