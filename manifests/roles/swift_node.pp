class havana::roles::swift_node {

  anchor { 'havana::profiles::swift::node': }
  Class { require => Anchor['havana::profiles::swift::node'] }

  # Determine the IP address
  $ip = hiera('network::internal::ip')

  $swift_disks = hiera('havana::swift::disks')

  package { 'xfsprogs':
    ensure => latest,
  }

  file { '/srv/node':
    ensure => directory,
    owner  => 'swift',
    group  => 'swift',
    mode   => '0644',
  }

  cubbystack::functions::create_swift_device { $swift_disks:
    swift_zone => $::swift_zone,
    ip         => $ip,
    require    => [File['/srv/node'], Package['xfsprogs']],
  }

  class { 'havana::profiles::common::users': }
  class { 'cubbystack::swift':
    settings => hiera('havana::swift::settings'),
    require  => Class['havana::profiles::common::users'],
  }
  class { 'havana::profiles::swift::rsync':
    require  => Class['havana::profiles::common::users'],
  }
  class { 'havana::profiles::swift::account':
    require  => Class['havana::profiles::common::users'],
  }
  class { 'havana::profiles::swift::container':
    require  => Class['havana::profiles::common::users'],
  }
  class { 'havana::profiles::swift::object':
    require  => Class['havana::profiles::common::users'],
  }

}
