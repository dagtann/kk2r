// Scatterplots for user specified correlations
// --------------------------------------------
// kkstata@web.de

version 12
set more off

preserve
clear

if "`1'" == "" local 1 = .5
local r = `1'

tempvar y x

drawnorm `y' `x', corr(1 `r' 1) cstorage(lower) n(4000)

graph twoway ///
  || scatter `y' `x', ms(oh)  ///
  || lfit `y' `x' ///
  || , ytitle(Y-Variable) xtitle(X-Variable)  /// 
  title(r = `r', bexpand box)  /// 
  legend(off) plotregion(lstyle(foreground))

exit

