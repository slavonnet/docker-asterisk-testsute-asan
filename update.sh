#!/bin/bash


mkdir onbuild-pjproject_trunk-testsute_master-asterisk_master
mkdir onbuild-pjproject_trunk-testsute_master-asterisk_13
mkdir onbuild-pjproject_2.4.5-testsute_master-asterisk_master
mkdir onbuild-pjproject_2.4.5-testsute_master-asterisk_13

for i in onbuild*; do 
	cp -f Dockerfile.template $i/Dockerfile
done

sed -i -e s!asterisk_branch=master!asterisk_branch=13! *asterisk_13*/Dockerfile
sed -i -e s!onbuild-pjproject_trunk-testsute_master!onbuild-pjproject_2.4.5-testsute_master! *pjproject_2.4.5*/Dockerfile



