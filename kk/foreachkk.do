// Some examples for foreach-loops 

version 12.0

// Example with Varlist
foreach X of varlist wor* { 
        tabulate `X' sex 
}

// Example with New-Varlist
foreach var of newlist r1-r10 { 
        generate  `var' = runiform() 
}

// Example with Numlist
foreach num of  numlist 1/10 { 
        replace r`num' = runiform() 
}

// Example with Anylist 
foreach piece in This sentence has 5 pieces { 
        display "`piece'" 
}

// Example with More than one line
foreach var of varlist ybirth income {
        summarize `var', meanonly
        generate `var'_c = `var' - r(mean) 
        label variable `var'_c "`var' (centered)"
}

// Parallell list structures
local i 1
foreach var of varlist eqp* {
        generate equip`i' = `var' - 1 
        local i = `i' + 1 
}

exit
