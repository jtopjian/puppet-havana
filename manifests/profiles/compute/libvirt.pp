class havana::profiles::compute::libvirt {


  class { 'cubbystack::nova::compute::libvirt':
    libvirt_type => hiera('havana::nova::compute::libvirt_type'),
  }

  ::cubbystack::functions::generic_service { 'libvirt-bin':
    package_name   => 'libvirt-bin',
    service_name   => 'libvirt-bin',
    package_ensure => latest,
    tags           => ['openstack', 'libvirt'],
  }

}
