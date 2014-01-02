class havana::profiles::compute::nova {

  anchor { 'havana::profiles::compute::nova': }
  Class { require => Anchor['havana::profiles::compute::nova'] }

  class { 'cubbystack::nova':
    settings => hiera('havana::nova::settings'),
  }

  class { 'cubbystack::nova::compute': }

  class { 'cubbystack::nova::compute::libvirt':
    libvirt_type => hiera('havana::nova::compute::libvirt_type'),
  }

  class { 'havana::profiles::compute::migration_support': }
}
