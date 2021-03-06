#!/bin/bash
## Test your drive using fio. The output should be similar to CrystalDiskMark on Windows
## fio_like_crystaldiskmark.sh
## by @makeme v.2020-08-07
if ! [ -x "$(command -v fio)" ]; then
  echo 'Please install fio' >&2
  exit 1
fi
filename=fiotest_
OPTIONS="--size=1G --ioengine=libaio --runtime=60 --direct=1"
## TESTS
SEQ1M_Q8T1_read ()
{
  fio --name=$filename$FUNCNAME --bs=1M --rw=read --max-jobs=1 --iodepth=16 $OPTIONS | grep READ | awk '{print $3}' | sed 's/(//;s/),//' && rm $filename*
}
SEQ1M_Q8T1_write ()
{
  fio --name=$filename$FUNCNAME --bs=1M --rw=write --max-jobs=1 --iodepth=16 $OPTIONS | grep WRITE | awk '{print $3}' | sed 's/(//;s/),//' && rm $filename*
}
SEQ1M_Q1T1_read ()
{
  fio --name=$filename$FUNCNAME --bs=1M --rw=read --max-jobs=1 --iodepth=2 $OPTIONS | grep READ | awk '{print $3}' | sed 's/(//;s/),//' && rm $filename*
}
SEQ1M_Q1T1_write ()
{
  fio --name=$filename$FUNCNAME --bs=1M --rw=write --max-jobs=1 --iodepth=2 $OPTIONS | grep WRITE | awk '{print $3}' | sed 's/(//;s/),//' && rm $filename*
}
RADN4K_Q32T16_read ()
{
  fio --name=$filename$FUNCNAME --bs=4k --rw=randread --max-jobs=16 --iodepth=64 $OPTIONS | grep READ | awk '{print $3}' | sed 's/(//;s/),//' && rm $filename*
}
RADN4K_Q32T16_write ()
{
  fio --name=$filename$FUNCNAME --bs=4k --rw=randwrite --max-jobs=16 --iodepth=64 $OPTIONS | grep WRITE | awk '{print $3}' | sed 's/(//;s/),//' && rm $filename*
}
RADN4K_Q1T1_read ()
{
  fio --name=$filename$FUNCNAME --bs=4k --rw=randread --max-jobs=1 --iodepth=2 $OPTIONS | grep READ | awk '{print $3}' | sed 's/(//;s/),//' && rm $filename*
}
RADN4K_Q1T1_write ()
{
  fio --name=$filename$FUNCNAME --bs=4k --rw=randwrite --max-jobs=1 --iodepth=2 $OPTIONS | grep WRITE | awk '{print $3}' | sed 's/(//;s/),//' && rm $filename*
}
## Let's go
echo -e "TestName READ WRITE" "\n"\
"SEQ1M_Q8T1" $(SEQ1M_Q8T1_read) $(SEQ1M_Q8T1_write)"\n"\
"SEQ1M_Q1T1" $(SEQ1M_Q1T1_read) $(SEQ1M_Q1T1_write)"\n"\
"RADN4K_Q32T16" $(RADN4K_Q32T16_read) $(RADN4K_Q32T16_write)"\n"\
"RADN4K_Q1T1" $(RADN4K_Q1T1_read) $(RADN4K_Q1T1_write) | column -t
