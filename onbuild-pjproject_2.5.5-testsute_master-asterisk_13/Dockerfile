FROM slavon/asterisk-testsute-baseimage:onbuild-pjproject_2.5.5-testsute_master

MAINTAINER Badalyan Vyacheslav <v.badalyan@open-bs.ru>

ENV asterisk_branch=13
ENV testsute_branch=master
ENV ASAN_OPTIONS="log_path=/tmp/asterisk_asan/log_"
ENV LSAN_OPTIONS="suppressions=/usr/src/testsute/MyLSan.supp"
ENV CYCLES=1
ENV TIMEOUT=160
ENV proc=32

RUN mkdir -p /tmp/asterisk_asan/

VOLUME /tmp/asterisk_asan/

### ASTERISK TEST SUTE

RUN git clone -b ${testsute_branch} --depth 1 https://gerrit.asterisk.org/testsuite /usr/src/testsute && \
	cd /usr/src/testsute/asttest && \
	make && make install && \
	cd /usr/src/testsute/addons && \
	make update && \
	cd starpy && \
	python setup.py install

### ASTERISK INSTALL
RUN git clone -b ${asterisk_branch} --depth 1 http://gerrit.asterisk.org/asterisk /usr/src/asterisk && \ 
	cd /usr/src/asterisk &&  \
	./configure  --prefix=/usr --enable-dev-mode && \
	make menuselect.makeopts && \ 
	menuselect/menuselect --enable ADDRESS_SANITIZER --enable-category MENUSELECT_TESTS --enable DONT_OPTIMIZE --enable TEST_FRAMEWORK menuselect.makeopts && \
	make -j${proc} && make install && make config && make samples && \
	rm -rf /usr/src/asterisk


WORKDIR /usr/src/testsute
COPY ./run-my-test.sh /usr/src/testsute/
COPY ./MyLSan.supp /usr/src/testsute/
RUN chmod a+x ./run-my-test.sh

ENTRYPOINT ./run-my-test.sh 
CMD ["-c"]



