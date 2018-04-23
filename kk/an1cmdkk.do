d
describe
cd c:\data\kk3
dir
dir *.dta
use data1
describe
drop  ymove - xweights
list
list  sex income
sort  income
list  sex income in 1/10
list in 1
list in 2/4
summarize income
summarize 
summarize income if sex == 1
summarize income if sex == 2
mvdecode income, mv(0=.a)
sort sex
by sex: summarize  income
summarize  income, detail
by sex: summarize  income if edu == 4, detail
tabulate  sex
tabulate emp sex
graph box income if income <= 250000, over(emp)
search Linear Regression
search Model
search OLS
help regress
generate men = 1 if sex == 1
replace men = 0 if sex == 2
generate emp3 = emp if emp <= 2
replace emp3 = 3 if emp == 4
tabulate emp emp3, missing
label variable emp3 "Status of employment (3 categories)"
label define emp3 1 "full time" 2 "part time" 3 "irregular"
label values emp3 emp3
regress income men i.emp3
doedit
do an1.do
dir *.do
pwd
exit
save mydata
