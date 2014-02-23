class havana::profiles::swift::account {

  anchor { 'havana::profiles::swift::account': }
  Class { require => Anchor['havana::profiles::swift::account'] }

  rsync::server::module { 'account':
    path            => '/srv/node',
    lock_file       => "/var/lock/account.lock",
    uid             => 'swift',
    gid             => 'swift',
    max_connections => 25,
    read_only       => false,
  }

  $ring_server = hiera('havana::swift_proxy')
  rsync::get { '/etc/swift/account.ring.gz':
    source => "rsync://${ring_server}/swift_server/account.ring.gz",
  }

  class { 'cubbystack::swift::account':
    settings => hiera_hash('havana::swift::account::settings'),
  }
}
