#!/usr/bin/env bash
VI=`which virt-install`
NAME=$1
RAM=512
DP="/home/oyj/kvm/images"
ISO_PATH="$DP/iso"
DFP="$DP/$NAME.img"
SIZE=20
VCPUS=1
OTYPE=linux
OV="ubuntu16.04"
NB="virbr0"

#$VI -n $NAME -r $RAM --os-type=$OTYPE --os-variant=$OV --disk path=$DFP,device=disk,bus=virtio,size=$SIZE,sparse=true,format=raw -w bridge=$NB,model=virtio  --console pty,target_type=serial -c $ISO_PATH/CentOS-7-x86_64-Minimal-1611.iso 

#$VI -n $NAME -r $RAM --os-type=$OTYPE --os-variant=$OV --disk path=$DFP,device=disk,bus=virtio,size=$SIZE,sparse=true,format=raw -w bridge=$NB,model=virtio --graphics none --console pty,target_type=serial --location $ISO_PATH/CentOS-7-x86_64-Minimal-1611.iso 


#--extra-args 'console=ttyS0,115200n8 serial'

$VI \
--name=$NAME \
--disk path=/home/oyj/kvm/images/$NAME.img,size=$SIZE,sparse=false,cache=none \
--graphics none \
--vcpus=$VCPUS --ram=$RAM \
--network bridge=$NB \
--os-type=$OSTYPE \
--os-variant=$OV \
--location $ISO_PATH/ubuntu-16.04.2-server-amd64.iso \
--extra-args="console=tty0 console=ttyS0,115200n8"
#--initrd-inject=/root/kvm_centos7.cfg \
#--extra-args="ks=file:/kvm_centos7.cfg console=tty0 console=ttyS0,115200n8"
