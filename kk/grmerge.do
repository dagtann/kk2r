// Schematic representation of merge (rectangular data)
// kkstata@web.de

version 12
preserve
clear

input x key str4 id
1 90 1
6 90 1
1 85 2
6 85 2
1 80 3
6 80 3
1 75 4
6 75 4
1 70 5
6 70 5
1 65 etc.
6 65 etc.
end

generate keybig = key if x == 1
generate keysmall = key if x == 6
separate key if id ~= "etc." , by(id)
local opt "connect(l) ms(i) clstyle(p1) legend(off)"
graph twoway  ///
  || scatter keybig keysmall x, ms(i..) mlabel(id id) mlabpos(9 3) /// The keys
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
  || line key1-key5 x, c(L..) clstyle(p1..) /// The key-connections 
  || , text(95 1 "Key") text(95 3 "Var 1") ///  The Chart-Junk
  text(95 6 "Key") text(95 8 "Var 2") ///
  text(100 2 "File 1", placement(n)) text(100  7 "File 2", placement(n)) ///
  plotregion(style(none))  /// 
  xscale(off) yscale(off) ylabel(, nogrid) scheme(s1mono)

restore
exit
