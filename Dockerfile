FROM slavon/asterisk-testsute-baseimage

MAINTAINER Badalyan Vyacheslav <v.badalyan@open-bs.ru>

ENV asterisk_branch=master
ENV ASAN_OPTIONS="log_path=/tmp/asterisk_asan/log_"
ENV LSAN_OPTIONS ""
ENV CYCLES=1
ENV TIMEOUT=160

RUN mkdir -p /tmp/asterisk_asan/

VOLUME /tmp/asterisk_asan/

### ASTERISK INSTALL
RUN git clone http://gerrit.asterisk.org/asterisk /usr/src/asterisk
WORKDIR /usr/src/asterisk
RUN git checkout -B ${asterisk_branch}
RUN ./configure  --prefix=/usr --enable-dev-mode
RUN make menuselect.makeopts
RUN menuselect/menuselect --enable ADDRESS_SANITIZER --enable-category MENUSELECT_TESTS --enable DONT_OPTIMIZE --enable TEST_FRAMEWORK menuselect.makeopts
RUN make -j"$(nproc)" make install && make config && make samples


#CLEANUP
RUN rm -rf /usr/src/asterisk

### RUN TEST!!

WORKDIR /usr/src/testsute
ENTRYPOINT ./runtests.py --random-order --number=${CYCLES} ${TIMEOUT} | tee /tmp/asterisk_asan/output.log
CMD ["-c"]



