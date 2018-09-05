# singleGPUvfio
___
This is actually a repo I'm not actively using right now.
The reason being is that I ended up getting a relatively cheap GTX680 for use in a FreeBSD virtual machine that runs on my Arch Linux host. The Windows 10 virtual machine gets the RX570. 

If anyone does have an issue with using these scripts then filing an issue is a great way for me to see it and work to fix it. Like I said, I use an Arch Linux host so that may also be an issue if you are using something like Debian Stable.
___

The order that I run the scripts usually goes like this:
    
    vfioCommand
    vfioUnbind
    qemuStart.sh
    
'qemuStart.sh' isn't necessarily what you need to run. If you're using libvirt you can use 'virsh start $nameOfVM' with whatever the name of your VM is.
