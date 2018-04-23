// Beatles data for fixed effects example
// kkstata@web.de

version 12
preserve
clear all

input persnr   time   lsat   age  
	1   1968      8    28  
	1   1969      6    29  
	1   1970      5    30  
	2   1968      5    26  
	2   1969      2    27  
	2   1970      1    28  
	3   1968      4    25  
	3   1969      3    26  
	3   1970      1    27  
	4   1968      9    28  
	4   1969      8    29  
	4   1970      6    30  
end
label variable persnr Person
label define name ///
  1 John 2 Paul 3 George 4 Ringo

label variable time "Year of observation"
label variable lsat "Life satisfaction (fictive)"
label variable age "Age in years"

label data "Kohler/Kreuter"
compress
save beatles
