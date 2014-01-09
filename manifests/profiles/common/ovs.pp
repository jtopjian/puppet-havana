class havana::profiles::common::ovs {

   $ovs_packages = ['openvswitch']
   $ovs_service  = 'openvswitch'

  package { 'openvswitch-datapath-dkms':
    name   => $ovs_packages,
    ensure => $present,
    notify => Service['openvswitch-switch'],
  }

  service { 'openvswitch-switch':
    name    => $ovs_service,
    ensure  => running,
  }

}
