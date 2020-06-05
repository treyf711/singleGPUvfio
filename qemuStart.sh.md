```
#!/bin/bash
keyboard="04d9:a0cd"
mouse="045e:0023"
```
```
export QEMU_AUDIO_DRV=alsa QEMU_AUDIO_TIMER_PERIOD=0
qemu-system-x86_64 \
    -enable-kvm -M q35 -m 4096 -cpu host -smp 2,sockets=1,cores=2,threads=1 \
    -bios /usr/share/qemu/bios.bin -vga none \
    -device ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root.1 \
    -device piix4-ide,bus=pcie.0,id=piix4-ide \
    -device vfio-pci,host=09:00.0,bus=root.1,addr=00.0,multifunction=on,x-vga=on,romfile=/storage/VM/Ellesmere.rom \
    -device vfio-pci,host=09:00.1,bus=pcie.0 \
    -usb -usbdevice host:${keyboard} -usbdevice host:${mouse} \
    -soundhw ac97 \
    -drive file=/storage/VM/win10.img,id=disk,format=raw -device ide-hd,bus=piix4-ide.0,drive=disk \
    -drive file=/storage/VM/win10.iso,id=isocd -device ide-cd,bus=piix4-ide.1,drive=isocd \
;
```
