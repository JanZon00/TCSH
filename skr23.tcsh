#! /usr/bin/tcsh
# Jan Zoń pjs gr1

if ($# != 3) then
	echo "wrong number of arguments, expected 3"
	exit 1
endif


if ( "$1" =~ "[-+*/%^]" ) then
	set operator = $1
	set a = $2
	set b = $3
else if ( "$2" =~ "[-+*/%^]" ) then
	set a = $1
	set operator = $2
	set b = $3
else if ( "$3" =~ "[-+*/%^]" ) then
	set a = $1
	set b = $2
	set operator = $3
else
	echo "operator not found"
	exit 2
endif

set re = '^-?[0-9]+$'
if (! ( "$a" =~ $re ) || ! ( "$b" =~ $re )) then
	echo "not a number"
	exit 1
endif

if ($a < $b) then
	@ x = $a
	while ($x <= $b)
		@ y = $a
		while ($y <= $b)
			@ result = $x $operator $y
			echo -n "$result "
			@ y++
		end
		echo ""
		@ x++
	end
else
	@ x = $a
	while ($x >= $b)
		@ y = $a
		while ($y >= $b)
			@ result = $x $operator $y
			echo -n "$result "
			@ y--
		end
		echo ""
		@ x--
	end
endif
