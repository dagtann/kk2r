use data1
drop  ymove - xweights
summarize income
mvdecode income, mv(0=.a)
sort sex
by sex: summarize income
summarize income, detail
generate men = 1 if sex == 1
replace men = 0 if sex == 2
generate emp3 = emp if emp <= 2
replace emp3 = 3 if emp == 4
label variable emp3 "Status of employment (3 categories)"
label define emp3 1 "full time" 2 "part time" 3 "irregular"
label values emp3 emp3
regress income men i.emp3
