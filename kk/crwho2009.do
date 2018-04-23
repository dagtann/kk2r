// Life expectancy 2009
// Source: http://apps.who.int/ghodata/#

version 12
clear
set more off

// Import downloaded Excel files
// ----------------------------


// Life expectancy
cd $daus3/downloaded_data
import excel country B year lexp_male E lexp_female G lexp_average  ///
  using vid.1250.xls ///
  , clear cellrange(A5:H583)
drop B E G

replace country = country[_n-1] if country==""
destring year lexp_male lexp_female lexp_average, replace

tempfile file1
save `file1'

// Literacy
import excel country B literacy ///
  using vid.2100.xls ///
  , clear cellrange(A5:C152)
drop B
destring literacy, replace force

tempfile file2
save `file2'

// Health expenditures
import excel country B year healthexp E healthexp_gov ///
  using vid.1900.xls ///
  , clear cellrange(A4:F194)
drop B year E
destring healthexp* , replace force
tempfile file3
save `file3'

// Lost healty years
import excel country B year lostyears ///
  using vid.1450.xls ///
  , clear cellrange(A4:F196)
drop B year
destring lostyears , replace force
tempfile file4
save `file4'

// Infant mortality
import excel country B mort_child ///
  using vid.1320-3.xls ///
  , clear cellrange(A5:C197)
drop B
destring mort_child, replace
tempfile file5
save `file5'

// Adult mortality
import excel country B year mort_male E mort_female G mort_both ///
  using vid.1360.xls ///
  , clear cellrange(A5:H583)
drop B mort_male mort_female E G
replace country = country[_n-1] if country==""
keep if year=="2009"
destring year mort_both, replace
tempfile file6
save `file6'

// Life expectancy
import excel country B year gdp E poor  ///
  using vid.93320.xls ///
  , clear cellrange(A4:F474)
drop B E

replace country = country[_n-1] if country==""
replace poor = "1" if trim(poor) == "<2.0"
destring year gdp poor, replace force
collapse (mean) gdp poor, by(country)

merge 1:m country using `file1', nogenerate
merge m:1 country using `file2', nogenerate
merge m:1 country using `file3', nogenerate
merge m:1 country using `file4', nogenerate
merge m:1 country using `file5', nogenerate
merge m:1 country using `file6', nogenerate

label data "Life expectancy at birth (WHO)"
label variable country "Country"
label variable year "Year"
label variable lexp_male "Male life expectancy (at birth)"
label variable lexp_female "Female life expectancy (at birth)"
label variable lexp_average "Life expectancy (at birth)"
label variable literacy "Adult literacy rate 2008 (%)"  
label variable mort_child "Under-five mortality rate 2010 (%)"
label variable healthexp "Total health expenditures 2009 (in % of GDP)"
label variable healthexp_gov "Government health expenditures 2009 (in % of total)"
label variable lostyears "Years of life lost by broader causes"
label variable gdp "GDP per capita in PPP (USD)"
label variable poor "Population below 1 USD PPP per day"
label variable mort_both "Adult mortality rate"

note: Adult mortality rate: Probability that a 15 year old person will die before reaching his/her 60th birthday.
note: Source: Global Health Observatory Data Repository
note: URL: http://apps.who.int/ghodata/#
order country year lexp* literacy mort_child mort_both healthexp* lostyears gdp poor

cd "$daus3dta"
save who2009, replace
exit
