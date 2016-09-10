#!/bin/bash
set +e

ARG1="$1" # fork or the things to send to fork

# get the master to accept all of the keys
if [ "$ARG1" == "fork" ]; then
	COMPLETE_URL="$2"
	PASSWORD="$3"
	while true ; do
		salt-key -A -y > /dev/null
		COUNT=$(salt-key -l accepted | wc -l)
		if [ "$COUNT" = "4" ] ; then
			echo "all keys have been accepted"
			sleep 5
			salt '*' test.ping
			DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
			SALT="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"
			sh $DIR/salt-deploy.sh $SALT $PASSWORD
			RETVAL=$?
			echo "returned from salt-deploy: $RETVAL"
			# in AWS you would send a notification to a WaitConditionHandle
			# to let it know if we were successful
			if [ "$COMPLETE_URL" != "" ]; then
				echo "sending signal to $COMPLETE_URL"
				/opt/aws/bin/cfn-signal -r 'salt deploy complete' -e $RETVAL "$COMPLETE_URL" 2>&1
			fi
			exit $RETVAL
		fi
		echo "waiting for salt minions to register"
		salt-key -L
		sleep 5
	done
else
	# fork the shell script, redirect output to a special log
	sh $0 "fork" $@ > /var/log/salt-deploy.log &
fi
