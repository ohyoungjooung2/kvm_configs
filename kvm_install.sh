#!/usr/bin/env bash
#Centos7, kvm installation summary script
#Ethernet card name
E_NAME="enp2s0"

#Basic kvm install adding virt-manager
yum -y install qemu-kvm libvirt virt-install bridge-utils virt-manager 
#kvm module confirmation
lsmod | grep kvm

#libvirtd start and register into systemctl service config tool?
systemctl start libvirtd
systemctl enable libvirtd


#Adding br0
nmcli c add type bridge autoconnect yes con-name br0 if name br0

#br0 ip address config
nmcli c modify br0 ipv4.addresses 10.0.0.30/24 ipv4.method manual


#br0 gateway
nmcli c modify br0 ipv4.gateway 10.0.0.1


#br0 dns config
echo "br0 dns config"
sleep 1
nmcli c modify br0 ipv4.dns 10.0.0.1

#Removing existing interface
echo "#Removing existing interface"
nmcli c delete $E_NAME

# Adding $E_NAME TO the member of br0
nmcli c add type bridge-slave autoconnect yes con-name $E_NAME ifname $E_NAME master br0


