// Solution for Example 1, Chapter 11
// ----------------------------------
// kkstata@web.de


version 12

use progex, clear
label define lsat .a "No answer" 0 "below avarage" 1 "above avarage"

local t 1984
foreach var of varlist ap6801-zp15701 {
	summarize `var' if `var' > -1, meanonly
	generate lsat`t':lsat = `var' > r(mean) if `var' > -1 
	replace lsat`t' = .a if `var' == -1 
	label variable lsat`t' "Life Satisfaction High/Low (`t++')" 
}
	
exit
	
	Explanation
	-----------

	We start by filling the local macro t with the value 1984.  In the
	lines below, Stata puts in 1984 each time it sees `t'.  Therefore
	Stata makes the variable lsat1984 in the first round of the loop. At
	the same time the macro `var' is expanded by the first variable
	name of the varlist ap6801-zp15701. That is: `var' becomes ap6801.

	The last time we call the loop `t' we use the macro expansion
	operator `t++'. With this expansion operator Stata inserts 1984 and
	add one to the inserted macro. That is, the macro t becomes 1985
	afterwards.

	Stata than proceeds through the commands in the loop the second
	time, this time using the second variable name for `var' and 1985
	vor `t'. This is repeated til the last variable name is reached. 

	Note that we used the command "label define" outside the loop, as
	we only need to define the label once. Note also that we linked the
	value label to the variable by putting it behind a colon in the new
	variable name of the generate-command.

