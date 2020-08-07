# fio_like_crystaldiskmark.sh

A simple bash wrapper for fio. 
The goal is to have the CrystalDiskMark's output in Windows on Linux using fio.

# Output examples:

$ fio_like_crystaldiskmark.sh
Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme0n1p1  458G  309G  126G  72% /

 TestName       READ      WRITE
 SEQ1M_Q8T1     3335MB/s  3140MB/s
 SEQ1M_Q1T1     3264MB/s  2942MB/s
 RADN4K_Q32T16  919MB/s   302MB/s
 RADN4K_Q1T1    84.0MB/s  196MB/s

$ fio_like_crystaldiskmark.sh
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda        916G  490G  380G  57% /storage

TestName       READ     WRITE
SEQ1M_Q8T1     132MB/s  137MB/s
SEQ1M_Q1T1     136MB/s  141MB/s
RADN4K_Q32T16  749kB/s  544kB/s
RADN4K_Q1T1    168kB/s  177kB/s

# Please note that the two tests are different and thus the results can be different
