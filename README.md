# How To Run

docker run [--rm -it | -d] -v LOCAL_FOLDER:/tmp/asterisk_asan --name asterisk-asan-master  slavon/docker-asterisk-testsute-asan 

- LOCAL_FOLDER - place for logs in local PC
- -d | **--rm -it** - backgroud / foreground 

# ENV Agrguments

- ASAN_OPTIONS - https://github.com/google/sanitizers/wiki/AddressSanitizerFlags
- LSAN_OPTIONS - https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer#flags
- CYCLES -  number of test cycles (-1 for any time)
- TIMEOUT - timeout in secods for one test

# Log files

- output.log - stdout of testsute
- log_.PID - if have ASAN or LSAN error its save to this file

# Defaults
- Timeut = 120s
- Cycles = 1


