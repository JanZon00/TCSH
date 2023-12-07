#! /usr/bin/tcsh
# Jan Zoń pjs gr1

set port = 12345
set counter_file = "counter.rc"
set counter = 0

alias save_counter_state 'rm -f $counter_file; 	echo "$counter" > "$counter_file"; echo "$port" >> "$counter_file"'

alias load_counter_state 'set counter = 0; if ( -e "$counter_file" ) then; set counter = `head -n 1 "$counter_file"`;  endif'


alias run_client 'nc 127.0.0.1 $port; echo "client is running..."; load_counter_state; @ counter++; save_counter_state; exit 1'

alias run_server 'set previous_port = `tail -n 1 "$counter_file"`; `if ( $previous_port != $port ) then; set counter = 0; save_counter_state; endif`; set counter = `head -n 1 "$counter_file"`; echo "Running server on port $port. Number of calls : $counter"; nc -l localhost $port'

if ( $#argv == 0 ) then
	run_server
else
	while ( 1 )
	switch ( "$argv[1]" )
		case "-c":
			run_client
			breaksw
		case "-s":
			run_server
			breaksw
		case "-p":
			set port = "$argv[2]"
			if ( $#argv > 2 ) then
				while (1)
					switch ( "$argv[3]" )
						case "-c":
							run_client
							breaksw
						case "-s":
							run_server
							breaksw
						default:
							echo "Wrong argument"
							exit 1
							break
					endsw
			else
				echo "provide 3 arguments eg: -p 12344 -c"
				exit 1
			endif
			set processed_p_option = 1
			breaksw
		default:
			if ( ! $processed_p_option ) then
				echo "Invalid option"
				exit 1
			endif
			break
	endsw
	end
endif
