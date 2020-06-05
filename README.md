# **Big Warning**
Since the last time I used this to do a hot pass of my GPU, the amdgpu has been known to break when trying to load and unload it. These tricks may no longer work..

# singleGPUvfio
___ 

___

The order that I run the scripts usually goes like this:
    
    vfioCommand
    vfioUnbind
    qemuStart.sh
    
'qemuStart.sh' isn't necessarily what you need to run. If you're using libvirt you can use 'virsh start $nameOfVM' with whatever the name of your VM is.

## 2020 Update
I haven't been using this method much any more since I feel that Proton has gotten to a point where it works as perceivably well as native. I had one outlier that was holding me back (looking at you session) but now feel much better about the state of things. I will still update this repo to help others that may need it.
