//  Produces Graph-Overview for Chapter 6
//  Author: kkstata@web.de

version 12
preserve

use data1.dta, clear

//  bar chart
graph bar size ///
  , over(area1, label(angle(45)))  ///
  title(bar chart) name(g1,replace) ///
  fysize(33) fxsize(33) nodraw 

//  pie chart
graph pie,  ///
  over(area1) title(pie chart)  ///
  name(g2,replace) nodraw

//  dot chart
graph dot (mean) size ///
  , over(area1) title(dot chart)  ///
  name(g3,replace) nodraw

//  box-and-whisker plots
graph box size ///
  , over(area1, label(angle(45))) title(box-and-whisker plot)  ///
  name(g4,replace) nodraw

//  twoway graphs
twoway scatter rent size, title(scatterplot)  ///
  name(g5a,replace) nodraw
twoway function y=sin(x), range(1 20) title(function plot)  ///
  name(g5b,replace) nodraw
twoway histogram rent, title(histogram)  ///
  name(g5c,replace) nodraw
	
//  scatterplot matrix

graph matrix dsat rent size, title(scatterplot matrix)  ///
  name(g6,replace) nodraw

//  Combine them:
graph combine g2 g3, rows(1) name(ur, replace) fysize(33) nodraw
graph combine g4 g6, rows(2) name(ll, replace) fxsize(33) nodraw
graph combine g5a g5b g5c, rows(3) name(lr, replace) title(Twoway types) nodraw
graph combine g1 ur ll lr, ysize(7) iscale(.5)
restore

exit
