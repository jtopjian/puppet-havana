#!/bin/bash
cd /root
source openrc
wget http://cdn.download.cirros-cloud.net/0.3.1/cirros-0.3.1-x86_64-disk.img
glance image-create --name CirrOS --disk-format qcow2 --container-format bare --is-public true < cirros-0.3.1*

neutron net-create --shared default
neutron subnet-create default --name default --allocation-pool start=192.168.1.100,end=192.168.1.200 192.168.1.0/24
neutron router-create default
neutron router-interface-add default default

nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
