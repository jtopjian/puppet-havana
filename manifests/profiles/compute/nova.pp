class havana::profiles::compute::nova {

  anchor { 'havana::profiles::compute::nova': }
  Class { require => Anchor['havana::profiles::compute::nova'] }

  class { 'cubbystack::nova':
    settings => hiera('havana::nova::settings'),
  }

  class { 'cubbystack::nova::compute': }

  service { 'messagebus':
    ensure => running,
  }

  service { 'libvirtd':
    ensure => running,
  }

}
