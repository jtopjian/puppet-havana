class havana::profiles::common::ovs {

  case $::operatingsystem {
    'Ubuntu': {
      $ovs_packages = ['openvswitch-common', 'openvswitch-switch', 'openvswitch-datapath-dkms']
      $ovs_service = 'openvswitch-switch'
    }
  }

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
