class havana::profiles::swift::object {

  anchor { 'havana::profiles::swift::object': }
  Class { require => Anchor['havana::profiles::swift::object'] }

  rsync::server::module { 'object':
    path            => '/srv/node',
    lock_file       => "/var/lock/object.lock",
    uid             => 'swift',
    gid             => 'swift',
    max_connections => 25,
    read_only       => false,
  }

  $ring_server = hiera('havana::swift_proxy')
  rsync::get { '/etc/swift/object.ring.gz':
    source => "rsync://${ring_server}/swift_server/object.ring.gz",
  }

  class { 'cubbystack::swift::object':
    settings => hiera('havana::swift::object::settings'),
  }

}
