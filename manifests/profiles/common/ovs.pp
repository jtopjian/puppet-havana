class havana::profiles::common::ovs {

   $ovs_packages = ['openvswitch-common', 'openvswitch-switch', 'openvswitch-datapath-dkms']
   $ovs_service  = 'openvswitch'

  package { $ovs_packages:
    ensure => $present,
    notify => Service['openvswitch-switch'],
  }

  service { 'openvswitch-switch':
    name    => $ovs_service,
    ensure  => running,
  }

}
