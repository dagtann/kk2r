// German Parlamentarians, 1949-1998
// Data from: Materialie Nr. 127 der Wiss. Dienste des Dt. Bundestages,
// April 1998; ISSN 0344 9130"

version 12
set more off
clear

//  Read Names, Birthdate and Last Party
//  ====================================
  
insheet using $daus3/downloaded_data/mdb_ges4.tsv, clear

keep v1 v2 v3 v4

ren v1 index
ren v2 name
ren v3 birthdate
ren v4 lparty

compress
tempfile 11
save `11'

//  Read Rest
//  =========

insheet using $daus3/downloaded_data/mdb_ges6.tsv, clear

ren v1 index

generate drop = 0

replace v2 = "" if v2 == "CDU" //  We Ignore the Fusion of CDU/CSU 

//  Sterbejahr
//  ----------
  
generate byte deaddate = .
foreach var of varlist v2-v31 {
  replace drop = date(`var',"DMY") > date("31.5.1949","DMY")  ///
	  & date(`var',"DMY") ~= .
  replace deaddate = date(`var',"DMY") if drop 
  replace `var' = "" if drop 
}

//  Memberships
//  -----------

forvalues i = 1/13 {
  replace drop = v2 == "`i'" 
  generate p`i':yesno =  drop 
  generate p`i'date = date(v3,"DM19Y") if drop & date(v3,"DM19Y") ~= .
  lab var p`i' "Member of Legislature `i'"
  replace v2 = "" if drop 
  replace v3 = "" if drop & date(v3,"DM19Y") ~= .
}

forvalues j = 3/30 {
  local k = `j'+1
  forvalues i = 1/13 {
    replace drop =  v`j' == "`i'" 
    replace p`i' = 1 if drop 
    replace p`i'date = date(v`k',"DM19Y") if drop & date(v`k',"DM19Y") ~= .
    replace v`j' = "" if drop 
    replace v`k' = "" if drop & date(v`k',"DM19Y") ~= .

  }
}

//  Mandatsniederlegung bzw. Aberkennung
//  ------------------------------------

generate str1 seatX = ""
generate str1 temp = ""
forvalues i = 3/31 {
  local j = `i' - 1
  capture confirm string variable v`i' v`j'
	if _rc == 0 {
		replace seatX = v`j'   ///
		  if (v`i' == "Mandatsniederlegung"   ///
		  | v`i' == "Mandatsverlust"    ///
		  | v`i' == "Mandatsaberkennung" )  & seatX == ""
		replace temp = ""
		replace temp = v`j'  ///
		  if (v`i' == "Mandatsniederlegung"    ///
		  | v`i' == "Mandatsverlust"    ///
		  | v`i' == "Mandatsaberkennung" )
		replace seatX = trim(seatX) + " " + trim(temp) if seatX ~= temp
		replace v`j' = ""  ///
		  if (v`i' == "Mandatsniederlegung"  ///
		  | v`i' == "Mandatsverlust"   ///
		  | v`i' == "Mandatsaberkennung" ) 
		replace v`i' = ""  ///
		  if (v`i' == "Mandatsniederlegung"  ///
		  | v`i' == "Mandatsverlust"   ///
		  | v`i' == "Mandatsaberkennung" )
	}
}

//  Date and Accession to a Party
//  -----------------------------

generate str1 chgdate = ""
generate str1 chgto = ""
 
forvalues i = 2/30 {
    local j = `i' + 1
    replace chgdate = v`i' if date(v`i',"DM19Y")~= . & chgdate == ""
    replace chgto = v`j' if date(v`i',"DM19Y")~= . & chgto == ""
    replace temp = ""
    replace temp = v`i' if date(v`i',"DM19Y") ~= . 
    replace chgdate = trim(chgdate) + " " + trim(temp) if chgdate ~= temp
    replace temp = ""
    replace temp = v`j' if date(v`i',"DM19Y") ~= . 
    replace chgto = trim(chgto) + " " + trim(temp) if chgto ~= temp
    replace v`j' = "" if date(v`i',"DM19Y") ~= .
    replace v`i' = "" if date(v`i',"DM19Y") ~= .
}
lab var chgdate "date of Accession to a party"


//  Constituencies
//  --------------

generate str1 constit= ""
replace constit = "VKW"  ///
  if index==1426 | (p11date == date("03.10.90","DM19Y") & index ~= 2661)
forvalues i = 3/31 {
	replace constit = v`i' if constit == ""
	replace temp = ""
	replace temp = v`i' if v`i' ~= ""
	replace constit = trim(constit) + " " + trim(temp) if constit ~= temp
}
lab var constit "constituency"


// Make Spell-Data
// ===============

//  Legis-Dates
//  -----------

generate pstart1 = date("7.09.1949","DMY")   if p1 
generate pstart2 = date("6.10.1953","DMY")   if p2 
generate pstart3 = date("15.10.1957","DMY")  if p3  
generate pstart4 = date("17.10.1961","DMY")  if p4   
generate pstart5 = date("19.10.1965","DMY")  if p5   
generate pstart6 = date("20.10.1969","DMY")  if p6  
generate pstart7 = date("13.12. 1972","DMY") if p7  
generate pstart8 = date("14.12. 1976","DMY") if p8  
generate pstart9 = date("4.11.1980","DMY")   if p9 
generate pstart10 = date("29.03.1983","DMY") if p10 
generate pstart11 = date("18.02.1987","DMY") if p11 
generate pstart12 = date("20.12.1990","DMY") if p12
generate pstart13 = date("10.11.1994","DMY") if p13

generate pend1 =   date("7.09.1953","DMY")     if p1 
generate pend2 =   date("6.10.1957","DMY")     if p2 
generate pend3 =   date("15.10.1961","DMY")    if p3 
generate pend4 =   date("17.10.1965","DMY")    if p4 
generate pend5 =   date("19.10.1969","DMY")    if p5 
generate pend6 =   date("22.09.1972","DMY")    if p6 
generate pend7 =   date("13.12.1976","DMY")    if p7 
generate pend8 =   date("4.11.1980","DMY")     if p8 
generate pend9 =   date("29.03.1983","DMY")    if p9 
generate pend10 =  date("18.02.1987","DMY")    if p10
generate pend11 =  date("20.12.1990","DMY")    if p11
generate pend12 =  date("10.11.1994","DMY")    if p12
generate pend13 = date("26.10.1998","DMY")     if p13


//  Begin/End of Membership in Parliament
//  -------------------------------------

forv i = 1/13 {

	generate end`i' = pend`i'
	replace end`i' = date(substr(seatX,1,8),"DM19Y")  ///
	  if date(substr(seatX,1,8),"DM19Y") > pstart`i'  ///
	  & date(substr(seatX,1,8),"DM19Y") <  pend`i'
	replace end`i' = date(substr(seatX,10,.),"DM19Y")  ///
	  if date(substr(seatX,10,.),"DM19Y") > pstart`i'  ///
	  & date(substr(seatX,10,.),"DM19Y") <  pend`i'
	replace end`i' = deaddate if deaddate > pstart`i' & deaddate < pend`i' 
	
	generate begin`i' = pstart`i'
	replace begin`i' =  p`i'date if p`i'date ~= . & p`i'date ~= end`i'
	
	generate byte endtyp`i':endtyp = 1
	replace endtyp`i' = 2  ///
	  if date(substr(seatX,1,8),"DM19Y") == end`i'
	replace endtyp`i' = 2  ///
	  if date(substr(seatX,10,.),"DM19Y") == end`i' 
	replace endtyp`i' = 3  ///
	  if deaddate == end`i'
}

//  Reshape to Long: Person - Legislature
//  -------------------------------------

merge 1:1 index using `11'
drop _merge v* drop p*date temp seatX

reshape long p begin end endtyp pstart pend , i(index) j(period)
keep if p

//  Reformat Constitueny String to Long
//  -----------------------------------

by index (period): generate lfd = _n
sort index lfd
save `11', replace

by index, sort: keep if _n==1

egen memberships = nwords(constit)
levelsof memberships, local(K)
foreach k of local K {
	egen constituency`k' = wordof(constit), word(`k')
}

keep index constituency*

reshape long constituency, i(index) j(lfd)
drop if constituency == ""
sort index lfd

tempfile 12
save `12'

use `11', clear
merge 1:1 index lfd using `12'

//  Create Party Episodes within Legislative Period
//  ------------------------------------------------

drop constit _merge
sort index period
save `11', replace

egen changes = nwords(chgdate)
levelsof changes, local(K)
foreach k of local K {
  egen chgto`k' = wordof(chgto), word(`k')
  egen X`k' = wordof(chgdate), word(`k')
  generate chgdate`k' = date(X`k',"DM19Y")
}

keep index period begin end chgdate? chgto?
reshape long chgto chgdate, i(index period) j(spell)

drop if !inrange(chgdate,begin,end)
sort index period spell
save `12', replace

use `11', clear
drop chgdate chgto
merge 1:n index period using `12'
sort index period spell


//  Episodetyp, Begin, End
//  -----------------------

generate str10 party = chgto
by index period, sort: replace party = lparty if _n==_N  & party == ""

replace begin = chgdate if chgdate ~= .
by index period (spell), sort: replace end = begin[_n + 1] if _n ~= _N

//  Harmonize Greens
//  ================

replace party = "GRU"  ///
  if index(party,"GR") & begin <  date("04.10.1990","DMY")
replace party = "GRU/B90"  ///
  if index(party,"GR") & begin >= date("04.10.1990","DMY")
replace party = "B90/GRU"  ///
  if index(party,"GR") & begin >= date("10.11.1994","DMY")
 
//  Make nice Data
//  ==============

drop _merge chgto chgdate spell lfd p lparty 

generate birthyear = year(date(birthdate,"DMY"))
generate birthmonth = month(date(birthdate,"DMY"))
generate birthday = day(date(birthdate,"DMY"))
drop birthdate

generate enddate = string(end,"%dm_D_CY")
generate begindate = string(begin,"%dD_M_Y")

tostring period, replace

lab var name "Name of Parlamentarian"
lab var birthyear "Year of Birth"
lab var birthmonth "Month of Birth"
lab var birthday "Day of Birth"
lab var deaddate "Date of Dead"
lab var index "Index-Number for Parlamentarian"
lab var period "Legislative Period"
lab var party "Fraction-Membership"
lab var constituency "Voted in Constituency/Country Party Ticket"
lab var endtyp "Reason for Leaving the Parliament"
lab def endtyp 1 "Expiration of Legislature"   ///
   2 "Depostion/Denial" 3 "Dead"
lab var begindate "Begin of Episode"
lab var enddate "End of Episode"
lab var pstart "Start of Legislative Period"
lab var pend "End of Legislative Period"

compress
label data "MoP, Germany 1949-1998"
note: Data produced with crmdb.do
note: Source: "Materialie Nr. 127 der Wiss. Dienste des Dt. Bundestages, April 1998, ISSN 0344 9130"

drop if (end - begin) == 0
drop begin end


order index name party period pstart pend constituency birth* deaddate  ///
   begindate enddate endtyp
format deaddate pstart pend %d

sort pstart name
save mdb, replace


exit


