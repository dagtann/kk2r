// Sampling distributions by sampling methods
// ------------------------------------------
// kkstata@web.de

version 11.1
set more off
preserve

set seed 741967

// Get data and store true value
use data1, clear
summarize ybirth, meanonly
local true = r(mean)

// Define postfile
tempname samples
tempfile post
postfile `samples' str30 sample srs mean using `post'

// Create variables needed in each round
generate r = runiform()
bysort psu (r): generate byte tagpsu = _n==1
bysort hhnr2009 (r): generate byte tag = _n==1
bysort hhnr2009 (r): generate hhweight = (3650 * _N)/100
bysort state (r): generate stateweight = _N/6

// Create empty vars
input SRS Cluster Twostage pps1 PPS Strata
end

// Draw random samples
quietly forvalues i = 1/1000 {

	// SRS
	replace r = runiform()
	sort r
	replace SRS = _n<=100

	// Cluster
	bysort tag (r): replace Cluster = _n<=57 & tag
	bysort hhnr2009 (persnr): replace Cluster = sum(Cluster)
	bysort hhnr2009 (persnr): replace Cluster = Cluster[_N]>=1

	// Two-stage
	bysort tag (r): replace Twostage = _n<=100 & tag
	bysort hhnr2009: replace Twostage = sum(Twostage)
	by hhnr2009: replace Twostage = Twostage[_N]>=1
	bysort hhnr2009 (r): replace Twostage = _n==1 & Twostage

	// PPS
	bysort psu: replace pps1 = runiform() < (_N/6494 * 50) & tagpsu
	by psu: replace pps1 = sum(pps1)
	by psu: replace pps1 = pps1[_N]
	by psu (r), sort: replace PPS = _n <=2 & pps1

	// Strata
	bysort state (r): replace Strata = _n<=6

	// Calculate and store means
	summarize ybirth if SRS, meanonly
	local srs = r(mean)
	foreach var of varlist Cluster Twostage PPS Strata {
		summarize ybirth if `var', meanonly
		post `samples' ("`var'") (`srs') (r(mean))
		if "`var'" == "Twostage" {
			summarize ybirth if `var' [aweight=hhweight], meanonly
			post `samples' ("`var' (weighted)") (`srs') (r(mean))
		}
		else if "`var'" == "Strata" {
			summarize ybirth if `var' [aweight=stateweight], meanonly
			post `samples' ("`var' (weighted)") (`srs') (r(mean))
		}
	}
}
postclose `samples'

// Process postfile
use `post', replace

label define Sample 1 "Cluster" 2 "Twostage" 3 "Twostage (weighted)" ///
  4 "PPS" 5 "Strata" 6 "Strata (weighted)"
encode sample, gen(Sample) label(Sample)

// Produce figure
twoway  ///
  || kdensity srs, lcolor(gs8) lpattern(solid)     ///
  || kdensity mean, lcolor(black) lpattern(solid) lwidth(*1.5)   ///
  || , by(Sample, legend(off) note("") ) ///
  xline(`true') ylab(0(.05).25)  ///
  xtitle(Mean year of birth)


exit

  
  
