#!/bin/bash


mkdir onbuild-pjproject_trunk-testsute_master-asterisk_master
mkdir onbuild-pjproject_trunk-testsute_master-asterisk_13
mkdir onbuild-pjproject_trunk-testsute_master-asterisk_14
mkdir onbuild-pjproject_2.6-testsute_master-asterisk_master
mkdir onbuild-pjproject_2.6-testsute_master-asterisk_13
mkdir onbuild-pjproject_2.6-testsute_master-asterisk_14

for i in onbuild*; do 
	cp -f Dockerfile.template $i/Dockerfile
	cp -f run-my-test.sh $i/run-my-test.sh
	cp -f MyLSan.supp $i/MyLSan.supp
	chmod a+x $i/run-my-test.sh
done

sed -i -e s!asterisk_branch=master!asterisk_branch=13! *asterisk_13*/Dockerfile
sed -i -e s!asterisk_branch=master!asterisk_branch=14! *asterisk_14*/Dockerfile
sed -i -e s!onbuild-pjproject_trunk-testsute_master!onbuild-pjproject_2.6-testsute_master! *pjproject_2.6*/Dockerfile



