# How To

## build fresh image 

- docker build -t slavon/docker-asterisk-testsute-asan

## run precompiled image
docker run [--rm -it | -d] -v LOCAL_FOLDER:/tmp/asterisk_asan --name asterisk-asan-master  slavon/docker-asterisk-testsute-asan 

- -v - share local and remove folders
- {LOCAL_FOLDER} - your local folder in PC
- --name - name of container
- -d - work in background 
- --rm - clean after rum (don't work with -d)
- -it - work in foreground 
- slavon/docker-asterisk-testsute-asan - our repo name

# ENV Agrguments

To pass env to comeainer use "-v ENV=VALUE"

- ASAN_OPTIONS - [ASAN options](https://github.com/google/sanitizers/wiki/AddressSanitizerFlags)
- LSAN_OPTIONS - [LSAN options](https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer#flags)
- TIMEOUT - timeout in secods for one test

# Log files

ASAN_TYPE/TEST_ID/\*.txt

where
- ASAN_TYPE is address-TYPE_OF_ASAN or leak
- TEST_ID is test where get bug

where \*.txt
- full.txt - asterisk full log 
- messages.txt - asterisk messages log
- runtest_log.txt - testsute log
- asan.txt - asan full error info

# Defaults
- Timeut = 120s

## Author 

Badalyan Vyacheslav
CIO, [SBS Soft](https://www.sbssoft.ru)


