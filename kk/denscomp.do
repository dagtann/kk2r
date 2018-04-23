use data1, clear
generate linc = log(income)
summarize linc, meanonly
generate xhelp = autocode(linc,50,r(min),r(max))
kdensity linc if sex == 1, gen(fmen) at(xhelp) nodraw
kdensity linc if sex == 2, gen(fwomen) at(xhelp) nodraw
graph twoway connected fmen fwomen xhelp ///
  , title(Income by Gender) ytitle(Density) xtitle(Log (Income)) ///
    legend(order(1 "Men" 2 "Women")) sort
exit
