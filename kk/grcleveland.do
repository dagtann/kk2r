* Produces Figure with Elements of Stata-Graphs

version 12

preserve
use data1 if hhsize == 1 & rent < 2000, clear

keep if !missing(size,rent)
generate rentout = rent  ///
  if (rent > 1000 & size < 500) ///
  | (rent < 1000 & size > 2000)

generate labpos = 12 if inlist(hhnr2009,88537,155211)
replace labpos = 3 if inlist(intnr,164614)

summarize rent, meanonly
local miny = r(min)-50
local maxy = r(max)+50
summarize size, meanonly
local minx = r(min)-30
local maxx = r(max)+30

local dataregion "msymbol(i) connect(l) lpattern(dot)"

twoway  ///
  || sc rent rentout size, xaxis(1,2) yaxis(1,2) ms(oh o) mcolor(fg fg) ///
  mlabel(hhnr2009 hhnr2009)  mlabvpos(labpos)   ///
  || scatteri  `miny' `minx' `maxy' `minx', `dataregion'   ///
  || scatteri  `maxy' `minx' `maxy' `maxx', `dataregion'   ///
  || scatteri  `maxy' `maxx' `miny' `maxx', `dataregion'   ///
  || scatteri  `miny' `maxx' `miny' `minx', `dataregion'   ///
  || scatteri   ///
  -530   -400 "Axis titles"      ///
  -310   -200 "Axis labels"                 ///
  -600   2250 "Legend"                     ///
  -310   1900 "x axis"                      ///
  -550   2550 "Tick lines"                  ///
  1200   -550 "y axis"                      ///
  1800   -500 "Plot region"                 ///
  1800     50 "Data region"                 ///
  1800    500 "Grid lines"                  ///
  1800   1100 "Marker symbols"              ///
  1800   1850 "Marker labels"               ///
  , msymbol(i) mlabcolor(black)             ///
  || pcarrowi 								   /// 
  -500  -250    400   -270     /// Y Axis title
  -500  -240   -280   1000     /// X Axis title
  -280   -50    -50   -150     /// Y Axis label
  -280   -40   -160    420     /// X Axis label
  -600  2250   -500   1850     /// Legend
  -280  1900   -100   1650     /// X-Axis
  -500  2720   -100   2250     /// Tick lines
  -500  2720      0   2600     /// 
  1250  -450   1375    -50     /// Y-Axis
  1750  -250   1550    -50     /// Plot-Region
  1750   250  `maxy' `minx'    /// Data-Region
  1750   600   1250    500     /// Grid lines   
  1750   610   1000    750     /// 
  1750  1250   1374   1085     /// Marker Symbols
  1750  1260   1161   1609     ///
  1750  2000   420    2152     /// Marker Labels
  1750  2010   322    2400     /// 
  , lstyle(p1) lcolor(black) lwidth(medthin) mcolor(black) ||  ///
  , graphregion(margin(vlarge))                       ///
  ytitle(Rent (monthly), axis(1)) xtitle(Home size, axis(1)) ///
  ylabel(0(500)1500, grid axis(1)) xlabel(0(500)2500, grid axis(1)) ///
  ytick(0(250)1500, axis(1)) xtick(0(250)2500, axis(1)) ///
  xscale(range(0 2500) axis(1)) yscale(range(0 1500) axis(1)) ///
  ytitle("", axis(2)) xtitle("", axis(2)) ///
  ylabel(none, axis(2)) xlabel(none, axis(2))  ///
  ytick(0(250)1500, axis(2)) xtick(0(250)2500, axis(2)) ///
  xscale(range(0 2500) axis(2)) yscale(range(0 1500) axis(2)) ///
  legend(order( 1 2) label(1 "All clear") label(2 "Suspicious")) ///
  scheme(s1mono) 


_gm_edit .Graph.plotregion1.yscale.min    =  0          // get back axis
_gm_edit .Graph.plotregion1.yscale.curmin =  0          // scaling for
_gm_edit .Graph.plotregion1.xscale.min    =  0          // scatter only
_gm_edit .Graph.plotregion1.xscale.curmin =  0
_gm_edit .Graph.plotregion1.yscale.max    = 1500
_gm_edit .Graph.plotregion1.yscale.curmax = 1500
_gm_edit .Graph.plotregion1.xscale.max    = 2500
_gm_edit .Graph.plotregion1.xscale.curmax = 2500

graph display

