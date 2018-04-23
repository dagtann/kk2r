// ---------
// date: 02/01/2012
// author: fkreuter
// Population Berlin as of 31.12.2010
// Data: Federal Statistical Office
// www: https://www-genesis.destatis.de/genesis/online
// restricted to ages 18-89
// ----------

cd $daus3/downloaded_data
import excel ../downloaded_data/berlin_statisbund.xls.xlsx  ///
  , sheet("Sheet1") clear
drop A
expand B
drop B
rename C age
generate ybirth=2010-age
drop if ybirth==.
drop age
notes: https://www-genesis.destatis.de/genesis/online
notes: Population in Berlin as of 31.12.2010 Federal Statistical Office Germany
notes: only ages 18-89
cd "$daus3dta"
compress
save berlin.dta, replace

exit
