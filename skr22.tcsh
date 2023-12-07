#! /usr/bin/tcsh
# Jan Zoń pjs gr1

if ($# >= 2) then
set a = $1
set b = $2

		if ($a < $b) then
			@ x = $a
			while ($x <= $b)
				@ y = $a
				while ($y <= $b)
					@ result = $x * $y
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
					@ result = $x * $y
					echo -n "$result "
					@ y--
				end
				echo ""
				@ x--
			end
		endif

else if ($# == 1) then
set a = 1
set b = $1

	if ($a < $b) then
		@ x = $a
		while ($x <= $b)
			@ y = $a
			while ($y <= $b)
				@ result = $x * $y
				echo -n "$result "
				@ y++
			end
			echo ""
			@ x++
		end
	else
		@ x = $b
		while($x <= $a)
			@ y = $b
			while ($y <= $a)
				@ result = $x * $y
				echo -n "$result "
				@ y++
			end
			echo ""
			@ x++
		end
	endif
else
	foreach value (1 2 3 4 5 6 7 8 9)
		foreach value2 (1 2 3 4 5 6 7 8 9)
			@ a = $value * $value2
			echo -n "$a "
		end
		echo ""
	end
endif
