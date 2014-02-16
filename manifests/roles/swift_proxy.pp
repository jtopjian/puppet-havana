class havana::roles::swift_proxy {

  anchor { 'havana::roles::swift_proxy': }
  Class { require => Anchor['havana::roles::swift_proxy'] }

  class { 'havana::profiles::common::users': }
  class { 'havana::profiles::common::memcached': }
  class { 'cubbystack::swift':
    settings => hiera('havana::swift::settings'),
    require  => Class['havana::profiles::common::users'],
  }
  class { 'havana::profiles::swift::rsync':
    require  => Class['havana::profiles::common::users']
  }
  class { 'havana::profiles::swift::rings':
    require  => Class['havana::profiles::common::users']
  }
  class { 'cubbystack::swift::proxy':
    settings => hiera('havana::swift::proxy::settings'),
    require  => Class['havana::profiles::common::users']
  }

  # Extra packages
  $packages = ['swift-plugin-s3', 'python-keystone', 'python-keystoneclient']
  package { $packages:
    ensure => latest,
  }

  # sets up an rsync service that can be used to sync the ring DB
  rsync::server::module { 'swift_server':
    path            => '/etc/swift',
    lock_file       => '/var/lock/swift_server.lock',
    uid             => 'swift',
    gid             => 'swift',
    max_connections => 5,
    read_only       => true,
  }

}
