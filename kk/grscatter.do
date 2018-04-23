* Scatterplots for Introduction to Regression

version 12
preserve
set more off
use who2009 if year==2009, clear

graph twoway ///
   || lfit lexp_female lexp_male                           ///
   || scatter lexp_female lexp_male, mlcolor(black) ms(Oh) ///
   , nodraw xtitle("Male life expectancy")   ///
     ytitle("Female life expectancy") legend(off)    ///
     name(g1, replace) 

graph twoway ///
  || lfit mort_child literacy     ///
  || scatter mort_child literacy, mlcolor(black) ms(Oh) ///
  , nodraw  ytitle(Child mortality (2010)) ///
    name(g2, replace) legend(off)

graph twoway ///
  || lfit mort_both healthexp     ///
  || scatter mort_both healthexp, mlcolor(black) ms(Oh) ///
  , nodraw  ytitle(Adult mortality (2009))  ///
    name(g3, replace) legend(off)
graph combine g1 g2 g3, rows(3) ysize(6) 

restore
