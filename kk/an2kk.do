* Income inequality between men and women in Germany (GSOEP-data)
* ---------------------------------------------------------------

version 12
set more off
capture log close
log using an2kk, replace

* Data: Subsample of GSOEP 2009
use data1, clear                             // -> Note 1 
drop ymove - xweights

* Descriptive statistic of income
summarize income
mvdecode income, mv(0=.a)                    // -> Note 2 
sort sex
by sex: summarize income
summarize income, detail

* Employment by sex
tabulate emp sex, colum nofreq               // -> Note 3 

* Preparation for regression analysis
generate men = sex == 1                      // Dummy for gender
generate emp3 = emp if emp!=5                // -> Note 4
label define emp3 ///
  1 "full time"   ///
  2 "part time"   ///
  3 "irregular" 						
label values emp3 emp3

* Regression analysis I
regress income men i.emp3

* Preparation for regression analysis II
generate age = 2009 - ybirth                 // Age 
summarize age if !missing(income,emp)             // -> Note 5 
generate age_c = age - r(mean)

* Regression analysis II
regress income i.emp c.men##c.age_c

log close
exit

Description
-----------

This is an analysis of income inequality between men and women in Germany.
Hypotheses: see Kohler/Kreuter (2012, chap. 1-2). The higher amount 
of part-time working women is not a sufficient explanation for the inequality
in average income between men and women. In addition, even though there 
is a higher income inequality among older people, younger women 
are still affected.

Notes:
------

1) SOEP - Education-Sample of samples A-D and F without random group 5
   (created with crdata1.do).
2) Respondents with zero incomes are excluded from further analysis.
3) Women are more often part-time employed than men. It is reasonable to 
   control for employment status. 
4) This command excludes all respondents who are not employed. 
5) Centering the age variable: see Aiken/West (1991).
