# tizen3.0_raspberrypi3

This repository contains scripts to create SD card for Tizen port to RaspberyPi3.

```
#./mksdcard.sh /dev/YOUR_SD_CARD
#dd if=boot.img of=/dev/YOUR_SD_CARD1
#dd if=rootfs.img of=/dev/YOUR_SD_CARD2
#dd if=system-data.img of=/dev/YOUR_SD_CARD3
#dd if=modules.img of=/dev/YOUR_SD_CARD6
```
Expected output from mksdcard.sh script:
```
piotr@bpower:~/src/rpi3_tizen$ sudo ./U3-BootloaderForSD/mkpart.sh /dev/sdc
========================================
Label          dev           size
========================================
boot             /dev/sdc1       32 MiB
rootfs           /dev/sdc2       3072 MiB
system-data      /dev/sdc3       512 MiB
[Extend]         /dev/sdc4
 user            /dev/sdc5       3748 MiB
 module          /dev/sdc6       20 MiB
Remove partition table...
1+0 records in
1+0 records out
512 bytes copied, 0,00269162 s, 190 kB/s
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 7,2 GiB, 7746879488 bytes, 15130624 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Created a new DOS disklabel with disk identifier 0x1ba7bdc1.
Created a new partition 1 of type 'W95 FAT16 (LBA)' and of size 32 MiB.
/dev/sdc2: Sector 16384 is already allocated.
Created a new partition 2 of type 'Linux' and of size 3 GiB.
/dev/sdc3: Created a new partition 3 of type 'Linux' and of size 3 MiB.
/dev/sdc4: Created a new partition 4 of type 'Extended' and of size 4,2 GiB.
/dev/sdc5: Created a new partition 5 of type 'Linux' and of size 3,7 GiB.
/dev/sdc6: Created a new partition 6 of type 'Linux' and of size 20 MiB.
/dev/sdc7: 
New situation:

Device     Boot    Start      End Sectors  Size Id Type
/dev/sdc1  *        8192    73727   65536   32M  e W95 FAT16 (LBA)
/dev/sdc2          73728  6365183 6291456    3G 83 Linux
/dev/sdc3           2048     8191    6144    3M 83 Linux
/dev/sdc4        6365184 15130623 8765440  4,2G  5 Extended
/dev/sdc5        6367232 14043135 7675904  3,7G 83 Linux
/dev/sdc6       14045184 14086143   40960   20M 83 Linux

Partition table entries are not in disk order.

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
mkfs.fat 3.0.28 (2015-05-16)
mkfs.fat: warning - lowercase labels might not work properly with DOS or Windows
/dev/sdc3 contains a ext4 file system labelled 'system-data'
        created on Tue Jun 20 16:47:18 2017
```
