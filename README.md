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

## 2020 Update
I haven't been using this method much any more since I feel that Proton has gotten to a point where it works as perceivably well as native. I had one outlier that was holding me back (looking at you session) but now feel much better about the state of things. I will still update this repo to help others that may need it.
