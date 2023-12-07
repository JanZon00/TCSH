#! /usr/bin/tcsh
# Jan Zoń pjs gr1

foreach value (1 2 3 4 5 6 7 8 9)
	foreach value2 (1 2 3 4 5 6 7 8 9)
		@ a = $value * $value2
		echo -n "$a "
	end
	echo ""
end
