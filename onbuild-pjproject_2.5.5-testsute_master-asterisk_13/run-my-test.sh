#!/bin/bash

./runtests.py -l | grep ") tests" | while read line; do 

	TEST_ID=`echo $line | cut -d " " -f1`
	TEST_NAME=`echo $line | cut -d " " -f2-9`

	./runtests.py -t $TEST_NAME --timeout=${TIMEOUT} | tee /tmp/asterisk_asan/output.log

	if [ `ls -1 /tmp/asterisk_asan/log_* | grep -c ""` -ne "0" ]; then
		TEST_FILES_PATH=`find /tmp/asterisk-testsuite -name "full.txt" | grep "run_1/full" | sed -e "s/full.txt//" | tail -n1`
		ASAN_FILES_PATH=`ls -1 /tmp/asterisk_asan/log_* | tail -n1`
		ASAN_TYPE=""
		ASAN_SUBTYPE=""

		if [ `cat $ASAN_FILES_PATH  | grep "ERROR" | grep -c "AddressSanitizer"` -ne "0" ]; then
			ASAN_SUBTYPE=`cat $ASAN_FILES_PATH  | grep "ERROR" | grep "AddressSanitizer" | cut -d" " -f 3`
			ASAN_TYPE=address-$ASAN_SUBTYPE
		else
			ASAN_TYPE=leak
		fi;

		mkdir -p /tmp/asterisk_asan/$ASAN_TYPE/$TEST_ID
		cp ${TEST_FILES_PATH}full.txt /tmp/asterisk_asan/$ASAN_TYPE/$TEST_ID/
		cp ${TEST_FILES_PATH}messages.txt /tmp/asterisk_asan/$ASAN_TYPE/$TEST_ID/
		cp $ASAN_FILES_PATH /tmp/asterisk_asan/$ASAN_TYPE/$TEST_ID/asan.txt
		cp /tmp/asterisk_asan/output.log /tmp/asterisk_asan/$ASAN_TYPE/$TEST_ID/runtest_log.txt
	fi

	rm -rf /tmp/asterisk_asan/output.log
	rm -rf /tmp/asterisk_asan/log_*
	rm -rf /var/log/asterisk/*
	rm -rf /tmp/asterisk-testsuite/*

done;


