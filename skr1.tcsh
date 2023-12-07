#! /usr/bin/tcsh
# Jan Zoń pjs gr1

if ( $# < 2 ) then
	echo "Wrong number of arguments, expected 2"
	exit 1
endif

set ip_start = $argv[1]
set ip_end = $argv[2]

set ip1_c = `echo $ip_start | awk -F"." '{print $1"."$2"."$3}'`
set ip2_c = `echo $ip_end | awk -F"." '{print $1"."$2"."$3}'`

if ( $ip1_c != $ip2_c ) then
	echo "Adresy nie sa w tej samej domenie klasy C"
	exit 1
endif

set start_parts = ( `echo $ip_start | tr "." " "` )
set end_parts = ( `echo $ip_end | tr "." " "` )

if ! ( $start_parts[1] >= 0 && $start_parts[2] >= 0 && $start_parts[3] >= 0 && $start_parts[4] >= 0 && $start_parts[1] <= 256 && $start_parts[2] <= 256 && $start_parts[3] <= 256 && $start_parts[4] <= 256 ) then
	echo "not a valid ip address"
	exit 1
endif

if ! ( $end_parts[1] >= 0 && $end_parts[2] >= 0 && $end_parts[3] >= 0 && $end_parts[4] >= 0 && $end_parts[1] <= 256 && $end_parts[2] <= 256 && $end_parts[3] <= 256 && $end_parts[4] <= 256 ) then
	echo "not a valid ip address"
	exit 1
endif

if ( $start_parts[4] > $end_parts[4] ) then
	set i = $end_parts[4]
	while ( $i <= $start_parts[4] )
		set current_ip = "${end_parts[1]}.${end_parts[2]}.${end_parts[3]}.$i"
		if ( `ping -c 1 -W 1 "$current_ip" >& /dev/null` ) then
			echo "$current_ip : alive"
		else
			echo "$current_ip : dead"
		endif
		@ i++
	end
else
	set i = $start_parts[4]
	while ( $i <= $end_parts[4] )
		set current_ip = "${start_parts[1]}.${start_parts[2]}.${start_parts[3]}.$i"
		if ( `ping -c 1 -W 1 "$current_ip" >& /dev/null` ) then
			echo "$current_ip : alive"
		else
			echo "$current_ip : dead"
		endif
		@ i++
	end
endif
