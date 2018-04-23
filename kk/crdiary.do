// Fictious diary
// kkstata@web.de

version 12
clear
input str40 activity bhour bmin str6 estring str40 location
	"Sleeping" 0 00 "7:30" "at home"
	"Getting up" 7 30 "7:40" "at home"
	"Using the bathroom" 7 40 "7:45" "at home"
	"Eating" 7 45 "8:15" "at home"
	"Getting dressed for school" "8:15" "8:45" "at home"
	"On the way" 8 45 "9:05" "in car"
	"In school" 9 05 "15:15" "school"
	"Playing basketball" 15 15 "17:00" "YMCA"
	"On the way" 17 00 "17:30" "in car"
	"Watching TV" 17 30 "18:00" "at home"
	"Eating" 18 00 "18:25" "at home"
	"Reading book from library" 18 25 "19:00" "at home"
	"Playing computer games" 19 00 "19:30" "at home"
	"Using the bathroom" 19 30 "20:30" "at home"
	"Watching TV" 20 30 "21:00" "at home"
	"Listening to bedtime story" 21 00 "21:20" "at home"
	"Sleeping" 21 20 "24:00" "at home"
end
compress
save diary, replace
exit
