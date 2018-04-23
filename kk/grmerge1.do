// Schematic representation of non-rectangular merge
// kkstata@web.de

version 12
preserve
clear

input x key str4 id
1 90 1
6 90 1
1 85 2
6 85 4
1 80 4
6 80 5
1 75 5
6 75 6
1 70 6
6 70 8
1 65 7
6 65 9
1 60 8
6 60 10
1 55 11
6 55 11
1 50 12
6 50 13
1 45 etc.
6 45 etc.
end

generate keybig = key if x == 1
generate keysmall = key if x == 6
separate key if id ~= "etc." , by(id)

foreach var of varlist key1-key12 {
   local linepart `"`linepart' || line `var' x, c(l) clstyle(p1)"'
}
        
local opt "connect(l) ms(i) clstyle(p1) legend(off)"

twoway  ///
   || sc keybig keysmall x, ms(i..) mlabel(id id) mlabpos(9 3)  /// The keys
   || scatteri   0 2 100 2, `opt' clstyle(p2) /// The dashed lines 
   || scatteri   0 7 100 7, `opt' clstyle(p2) /// 
   || scatteri   0 0 100 0, `opt'  /// The boxes
   || scatteri 100 0 100 4, `opt'  ///
   || scatteri 100 4   0 4, `opt'  ///
   || scatteri   0 4   0 0, `opt'  ///
   || scatteri   0 5 100 5, `opt'  ///
   || scatteri 100 5 100 9, `opt'  ///
   || scatteri 100 9   0 9, `opt'  ///
   || scatteri   0 9   0 5, `opt'  ///
   `linepart'                      /// The key-connections 
   , text(95 1 "Key") text(95 3 "Var 1") ///  The Chart-Junk
     text(95 6 "Key") text(95 8 "Var 2") ///
     text(100 2 "File 1", placement(n)) text(100  7 "File 2", placement(n)) ///
     plotregion(style(none))  /// 
     xscale(off) yscale(off) ylabel(, nogrid) scheme(s1mono)

exit
