// Schematic representation of n:1 merges
// kkstata@web.de

preserve
clear

input x key str4 id
1 90 1
6 90 1
1 85 1
6 90 1
1 80 1
6 90 1
1 75 2
6 85 2
1 70 2
6 85 2
1 65 2
6 85 2
1 60 3
6 80 3
1 55 3
6 80 3
1 50 3
6 80 3
1 45 etc.
6 75 etc.
end

generate keybig = key if x == 1
generate keysmall = key if x == 6
separate key if id ~= "etc." , by(id)
local opt "connect(l) ms(i) clstyle(p1) legend(off)"
twoway  ///
   || scatter keybig keysmall x, ms(i..) mlabel(id id) mlabpos(9 3) /// The keys
   || scatteri   0 2 100 2, `opt' clstyle(p2) /// The dashed lines 
   || scatteri  66 7 100 7, `opt' clstyle(p2) /// 
   || scatteri   0 0 100 0, `opt'  /// The boxes
   || scatteri 100 0 100 4, `opt'  ///
   || scatteri 100 4   0 4, `opt'  ///
   || scatteri   0 4   0 0, `opt'  ///
   || scatteri  66 5 100 5, `opt'  ///
   || scatteri 100 5 100 9, `opt'  ///
   || scatteri 100 9  66 9, `opt'  ///
   || scatteri  66 9  66 5, `opt'  ///
   || line key1-key3 x, c(L L L) clstyle(p1 p1 p1) /// The key-connections 
   || , text(95 1 "Key") text(95 3 "Var 1") ///  The Chart-Junk
     text(95 6 "Key") text(95 8 "Var 2") ///
     text(100 2 "File 1", placement(n)) text(100  7 "File 2", placement(n)) ///
     plotregion(style(none))  /// 
     xscale(off) yscale(off) ylabel(, nogrid) scheme(s1mono)

exit
