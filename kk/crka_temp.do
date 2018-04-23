// Creates ka_temp with labels from Edition 2
version 12

use $daus3/downloaded_data/daus2_ka_temp, clear

label variable year "Year"
label variable jan "Average temp in January"
label variable feb "Average temp in February"
label variable mar "Average temp in March"
label variable apr "Average temp in April"
label variable may "Average temp in May"
label variable jun "Average temp in June"
label variable jul "Average temp in July"
label variable aug "Average temp in August"
label variable sep "Average temp in September"
label variable okt "Average temp in October"
label variable nov "Average temp in November"
label variable dec "Average temp in December"
label variable mean "Average yearly temp"

save ka_temp, replace

exit
