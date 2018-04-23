// Graph variants of beta distributions
// kkstata@web.de

local opt lcolor(black) 
twoway ///
||   function y1 = betaden( 1, 1,x), `opt' range(0 1) lpattern(solid) ///
||   function y2 = betaden(.5,.5,x), `opt' range(0.03 .97) lpattern(dash) ///
||   function y3 = betaden(.5, 2,x), `opt' range(0.08 1) lpattern(dot) ///
||   function y4 = betaden( 2,.5,x), `opt' range(0 .92) lpattern(longdash_dot) ///
||   function y5 = betaden( 2, 5,x), `opt' range(0 1) lpattern(longdash) ///
||   function y6 = betaden( 5, 2,x), `opt' range(0 1) lpattern(dash_dot) ///
|| , legend(order(  ///
  1 "rbeta(1,1)" 2 "rbeta(.5,.5)" 3 "rbeta(.5,2)" ///
  4 "rbeta(2,.5)" 5 "rbeta(2,5)" 6 "rbeta(5,2)") rows(2)) ///
  ytitle(Density) ylabel(0(.5)2.5, grid)  ///
  xtitle(Value of generated variable) xlabel(0(.2)1)

