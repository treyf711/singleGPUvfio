#!/bin/bash

unbind_vtconsoles()
{
    for ((i = 0; i < 16; i++))
    do
        if [ -d "/sys/class/vtconsole/vtcon$i" ]; then
            if [ `cat /sys/class/vtconsole/vtcon$i/name | grep -c "frame buffer"` -eq 1 ]; then
                while [ `cat /sys/class/vtconsole/vtcon$i/bind` -ne 0 ]; do
                    echo Unbinding vtcon$i
                    echo 0 > /sys/class/vtconsole/vtcon$i/bind
                    sleep 1
                done
            fi
        fi
    done
}

bind_vtconsoles()
{
    for ((i = 0; i < 16; i++))
    do
        if [ -d "/sys/class/vtconsole/vtcon$i" ]; then
            if [ `cat /sys/class/vtconsole/vtcon$i/name | grep -c "frame buffer"` -eq 1 ]; then
                echo 0 > /sys/class/vtconsole/vtcon$i/bind
                while [ `cat /sys/class/vtconsole/vtcon$i/bind` -ne 1 ]; do            
                    echo Binding vtcon$i
                    if [ ! -e "/dev/dri" ]; then
                        vbetool vbestate restore < /usr/local/etc/vbestate
                    fi
                    echo 1 > /sys/class/vtconsole/vtcon$i/bind
                    sleep 1
                done
            fi
        fi
    done
}

wait_lightdm_quit()
{
    while [ `ps ax | grep -c lightdm` -gt 1 ]; do
        sleep 1
    done
}

_rmmod()
{
    output=`rmmod $1 2>&1`
    status="$?"
    if [ `echo $output | grep -c "not currently loaded"` -eq 1 ]; then
        true
    else
        [[ -n $output ]] && >&2 echo $output
        `exit $status`
    fi
}

load_amdgpu()
{
    modprobe amdgpu
}

unload_amdgpu()
{
    _rmmod amdgpu
    _rmmod ttm
    _rmmod drm_kms_helper
}



load_fb()
{
    modprobe efifb
}

unload_fb()
{
    _rmmod efifb
}

stopVFIO()
{       
    load_fb
    bind_vtconsoles           
    load_amdgpu
    systemctl start lightdm
}

startVFIO()
{
    unload_amdgpu
    systemctl stop lightdm   
    wait_lightdm_quit
    unbind_vtconsoles
    unload_fb    
    
}

if [ "$1" == "start" ]; then
    startVFIO
else
    echo "[start|stop] not specified!"
    echo "You need to specify either start or stop"
    exit 1
fi
