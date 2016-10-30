FROM slavon/asterisk-testsute-baseimage:onbuild-pjproject_trunk-testsute_master

MAINTAINER Badalyan Vyacheslav <v.badalyan@open-bs.ru>

ENV asterisk_branch=master
ENV testsute_branch=master
ENV CYCLES=1
ENV TIMEOUT=160

RUN mkdir -p /tmp/asterisk_asan/

VOLUME /tmp/asterisk_asan/

### ASTERISK TEST SUTE

RUN git clone -b ${testsute_branch} --depth 1 https://gerrit.asterisk.org/testsuite /usr/src/testsute && \
	cd /usr/src/testsute/asttest && \
	sed -i -e "s/500000/30000000/" lib/lua/astlib.lua && \
	sed -i -e "s/timeout = 90 if self.valgrind_enabled else 5/timeout = 90 if self.valgrind_enabled else 30/" ./../lib/python/asterisk/asterisk.py && \
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
	menuselect/menuselect --enable ADDRESS_SANITIZER --enable UNDEFINED_SANITIZER --enable-category MENUSELECT_TESTS --enable DONT_OPTIMIZE --enable TEST_FRAMEWORK menuselect.makeopts && \
	make && make install && make config && make samples 
###	rm -rf /usr/src/asterisk

ENV ASAN_OPTIONS log_path=/tmp/asterisk_asan/log_:verbosity=1
ENV LSAN_OPTIONS suppressions=/usr/src/testsute/MyLSan.supp
ENV UBSAN_OPTIONS print_stacktrace=1

WORKDIR /usr/src/testsute
COPY ./run-my-test.sh /usr/src/testsute/
COPY ./MyLSan.supp /usr/src/testsute/
RUN chmod a+x ./run-my-test.sh

ENTRYPOINT ./run-my-test.sh 
CMD ["-c"]



