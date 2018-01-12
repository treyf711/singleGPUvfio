#!/bin/bash
keyboard="04d9:a0cd"
mouse="045e:0023"

for i in {4..7}
do
    echo  performance > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor
done

qemu-system-x86_64 \
    -display none \
    -enable-kvm \
    -M pc,accel=kvm \
    -m 8192 \
    -boot c \
    -drive file=/mnt/storage/VM/win10.img,format=raw,if=virtio \
    -drive file=/dev/sdb2,format=raw,if=virtio \
    -cpu host,kvm=off,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
    -smp 8,sockets=1,cores=4,threads=2 \
    -rtc base=localtime,driftfix=slew \
    -device ioh3420,bus=pci.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root \
    -device vfio-pci,host=01:00.0,bus=root,addr=00.0,romfile=/mnt/storage/VM/Ellesmere.rom,multifunction=on,x-vga=on -vga none \
    -device vfio-pci,host=01:00.1,bus=root,addr=00.1 \
    -device vfio-pci,host=00:14.2 \
    -netdev bridge,id=bridger \
    -device virtio-net-pci,netdev=bridger \
    -usbdevice host:${keyboard} -usbdevice host:${mouse} 
