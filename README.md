# How To

## build fresh image 

- docker build -t slavon/docker-asterisk-testsute-asan

## rum precompiled image
docker run [--rm -it | -d] -v LOCAL_FOLDER:/tmp/asterisk_asan --name asterisk-asan-master  slavon/docker-asterisk-testsute-asan 

- -v - share local and remove folders
- {LOCAL_FOLDER} - your local folder in PC
- --name - name of container
- -d - if you need backgroudn work 
- --rm - clean after rum (don't work with -d)
- -it - foreground 
- slavon/docker-asterisk-testsute-asan - repo name

# ENV Agrguments

To pass env to comeainer use "-v ENV=VALUE"

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

## Author 

Badalyan Vyacheslav
CIO, [Open Business Solutions][https://www.open-bs.ru]


