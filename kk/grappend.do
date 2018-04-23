// Schematic representation of append
// kkstata@web.de

version 12
clear
preserve

input x var1 str5 val
1 15 "Var 1"
1 14 0
1 13 1
1 12 0
1 11 0
1 10 1
1  9 etc.
3 15 "Var 2"
3 14 2002
3 13 1876
3 12 3000
3 11 2130
3 10 1000
3  9 etc.
1  7 "Var 1"
1  6 0
1  5 1
1  4 etc.
3  7 "Var 2"
3  6 1238
3  5 1500
3  4 etc.
5  7 "Var 3"
5  6 7
5  5 9
5  4 etc.
end

// Extract Graphsize from Scheme (thanks vwiggins@stata.com)
twoway scatteri 1 1, nodraw
local ysize "`.Graph._scheme.graphsize.y'"
local ysize = `ysize'*1.3
local opt "connect(l) ms(i) clstyle(p1) legend(off)"
twoway  ///
   || scatter var1 x, ms(i) mlabel(val) mlabpos(0)  /// The keys
   || scatteri   8.7 2 15.5 2, `opt' clstyle(p2) clpattern(dot) /// The dashed lines 
   || scatteri   3.7 2    7.5 2, `opt' clstyle(p2)  clpattern(dot) /// 
   || scatteri   3.7 4    7.5 4, `opt' clstyle(p2)  clpattern(dot) /// 
   || scatteri   8.7 0   15.5 0, `opt'  /// file 1 box
   || scatteri  15.5 0 15.5 4, `opt'  ///
   || scatteri  15.5 4    8.7 4, `opt'  ///
   || scatteri     8.7 4    8.7 0, `opt'  /// 
   || scatteri   3.7 0 7.5 0, `opt'  /// file 2 box
   || scatteri   7.5 0   7.5 6, `opt'  ///
   || scatteri   7.5 6   3.7 6, `opt'  ///
   || scatteri     3.7 6   3.7 0, `opt'  ///
   || , text(15.5 2 "File 1", placement(n)) ///
     text(7.5  3 "File 2", placement(n)) ///
     plotregion(style(none) margin(zero))  /// 
     xscale(off) yscale(off) ylabel(, nogrid) xsize(`xsize') ysize(`ysize') scheme(s1mono)

exit

