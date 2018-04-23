* Create Ansombe Quartet
version 12
preserve
clear

input x1 x2 x3 x4  y1 y2 y3 y4
	10  10  10   8      8.04     9.14      7.46      6.58
	8   8   8   8      6.95     8.14      6.77      5.76
	13  13  13   8      7.58     8.74     12.74      7.71
	9   9   9   8      8.81     8.77      7.11      8.84
	11  11  11   8      8.33     9.26      7.81      8.47
	14  14  14   8      9.96     8.10      8.84      7.04
	6   6   6   8      7.24     6.13      6.08      5.25
	4   4   4   8      4.26     3.10      5.39      5.56
	12  12  12  19     10.84     9.13      8.15     12.50
	7   7   7   8      4.82     7.26      6.42      7.91
	5   5   5   8      5.68     4.74      5.73      6.89
end

label data "Anscombe (1973)"
note: Anscombe 1973, Graphs in Statistical Anlysis. American Statistician 27,17--21
compress
save anscombe, replace
restore

exit


