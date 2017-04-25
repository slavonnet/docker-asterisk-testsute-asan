#!/bin/bash

rm -rf /tmp/asterisk-testsuite/*

./runtests.py -l | grep ") tests" | while read line; do 

	TEST_ID=`echo $line | cut -d " " -f1`
	TEST_NAME=`echo $line | cut -d " " -f2-9`
	TEST_FILES_PATH=""
	ASAN_TYPE="no_asan"
	ASAN_SUBTYPE=""

	./runtests.py -t $TEST_NAME --timeout=${TIMEOUT} | tee /tmp/asterisk_asan/output.log

	TEST_FILES_PATH=`find /tmp/asterisk-testsuite -name "full.txt" | grep "run_1/full" | sed -e "s/full.txt//" | tail -n1`

	for asan_file in `ls -1 /tmp/asterisk_asan/log_* 2>/dev/null`; do
		if [ `cat $asan_file  | grep "ERROR" | grep -c "AddressSanitizer"` -ne "0" ]; then
			ASAN_SUBTYPE=`cat $asan_file  | grep "ERROR" | grep "AddressSanitizer" | cut -d" " -f 3`
			ASAN_TYPE=address-$ASAN_SUBTYPE
		else
			ASAN_TYPE=leak
		fi;
		mkdir -p /tmp/asterisk_asan/$ASAN_TYPE/$TEST_ID
		cp $asan_file /tmp/asterisk_asan/$ASAN_TYPE/$TEST_ID/
	done;

	for i in `ls -1d /tmp/asterisk_asan/*/$TEST_ID`; do
		cp ${TEST_FILES_PATH}full.txt $i/
		cp ${TEST_FILES_PATH}messages.txt $i/
		cp /tmp/asterisk_asan/output.log $i/runtest_log.txt
	done;

	rm -rf /tmp/asterisk_asan/output.log
	rm -rf /tmp/asterisk_asan/log_*
	rm -rf /var/log/asterisk/*

	killall -9 asterisk

	find /tmp/asterisk-testsuite -name "full.txt" -delete
done;


