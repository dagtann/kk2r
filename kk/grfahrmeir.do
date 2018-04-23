// Fraction of a Histogram
// kkstata@web.de

version 12
local opt "connect(line) msymbol(i) clstyle(p1)"
twoway ///
   || scatteri   3  1  3  2, `opt'  ///
   || scatteri   0  2  4  2, `opt'  ///
   || scatteri   4  2  4  3, `opt'  /// 
   || scatteri   0  3  7  3, `opt'  /// file 2 box
   || scatteri   7  3  7  4, `opt'  ///
   || scatteri   0  4  7  4, `opt'  ///
   || scatteri   5  4  5  5, `opt'  ///
  , plotregion(style(none) margin(zero)) legend(off) scheme(s1mono) /// 
  xscale(line range(0.5 5.5)) ///
  xlabel(2.8 "x{subscript:1}" 3.1 "x" 3.9 "x{subscript:2}" ///
  , nogrid tposition(crossing) tlength(*2) labsize(*2) ) ///
  xtitle("") ///
  yscale(off) ylabel(, nogrid) 
exit

