// Exemplary analyses for Kohler/Kreuter, Data analysis using Stata
do crdata1                           // creation extract of SOEP'09 
do ancheck1                            // error checks in data1.dta 
do crdata1V2                   // correction of errors in data1.dta 
do ancheck1V2                        // error checks in data1V2.dta 
erase data1.dta 
do an1                               // income inequality men/women 
do anrent                                   // description of rents 
do anpi                                // Partisanship by ownership 

// Error in data1V2, -> correction and repetition in an1 - anpi
do anerror                      // discovery of error in data1V2.do 
do crdata1V3                 // correction of errors in data1V2.dta 
do an1V2                             // corrected results of an1.do 
do anrentV2                      // corrected results of anmiete.do 
do anpiV2                           // corrected results of anpi.do 
exit
