#!/bin/bash

# script  starts/stops multiple listed virtual machines

started=vm_current_list.txt
normal_log=normal_log.log
error_log=error_log.log
all_log=all_log.log

#list vms to a  file started
/usr/sbin/qm list --full > $started

#append date to file
echo "The abc_on_off script ran at: $(date)" | tee -a $started

#Insert Vm ID here:
vms=(108 109 110 997)
for n in ${vms[@]} 
do
	# condition if vm is running
	if  grep -q "$n" $started && grep -q "running" $started 
	then
        	echo "vm $n stopped"
		qm stop $n &>>$all_log
		# sleep 5
	else
		# condition if vm is stopped
		if  grep -q "$n" $started && grep -q "stopped" $started
		then
			echo "vm $n started"
       			qm start $n &>>$all_log
			# sleep 5
		fi
	fi		
done

