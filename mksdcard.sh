#!/bin/bash

DISK=$1
SIZE=`sfdisk -s $DISK`
SIZE_MB=$((SIZE >> 10))

BOOT_SZ=32
ROOTFS_SZ=3072
DATA_SZ=512
MODULE_SZ=20

let "USER_SZ = $SIZE_MB - $BOOT_SZ - $ROOTFS_SZ - $DATA_SZ - $MODULE_SZ - 4"

BOOT=boot
ROOTFS=rootfs
SYSTEMDATA=system-data
USER=user
MODULE=module

if [[ $USER_SZ -le 100 ]]
then
	echo "We recommend to use more than 4GB disk"
	exit 0
fi

echo "========================================"
echo "Label          dev           size"
echo "========================================"
echo $BOOT"		" $DISK"1  	" $BOOT_SZ "MiB"
echo $ROOTFS"		" $DISK"2  	" $ROOTFS_SZ "MiB"
echo $SYSTEMDATA"	" $DISK"3  	" $DATA_SZ "MiB"
echo "[Extend]""	" $DISK"4"
echo " "$USER"		" $DISK"5  	" $USER_SZ "MiB"
echo " "$MODULE"		" $DISK"6  	" $MODULE_SZ "MiB"


MOUNT_LIST=`mount | grep $DISK | awk '{print $1}'`
for mnt in $MOUNT_LIST
do
	umount $mnt
done

echo "Remove partition table..."                                                
dd if=/dev/zero of=$DISK bs=512 count=1 conv=notrunc

sfdisk $DISK <<-__EOF__
4MiB,${BOOT_SZ}MiB,0xE,*
8MiB,${ROOTFS_SZ}MiB,,-
,${DATA_SZ}MiB,,-
,,E,-
,${USER_SZ}MiB,,-
,${MODULE_SZ}MiB,,-
__EOF__

mkfs.vfat -F 16 ${DISK}1 -n $BOOT
mkfs.ext4 -q ${DISK}2 -L $ROOTFS -F
mkfs.ext4 -q ${DISK}3 -L $SYSTEMDATA -F
mkfs.ext4 -q ${DISK}5 -L $USER -F
mkfs.ext4 -q ${DISK}6 -L $MODULE -F
