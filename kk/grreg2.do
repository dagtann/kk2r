* Creates Scatterplot mit vollen Punkten

version 12
preserve
clear
input x y
    1          3
    2          2
    3          4
    4        3.4
    5          7
end

graph twoway 							/// 
  || scatter  y x, msize(*2) 			 ///
  || lfit y x, lwidth(*2) 				///
  || , xlab(0(1)6) xline(1(1)5) ylab(0(1)8) yline(1(1)7) 
  
restore

exit



