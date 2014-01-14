class havana::profiles::swift::rsync {

  anchor { 'havana::profiles::swift::rsync': }
  Class { require => Anchor['havana::profiles::swift::rsync'] }

  # Determine the IP address
  $interface = hiera('havana::network::internal::device')
  $ip = getvar("ipaddress_${interface}")

  # sets up an rsync service that can be used to sync the ring DB
  rsync::server::module { 'swift_server':
    path            => '/etc/swift',
    lock_file       => '/var/lock/swift_server.lock',
    uid             => 'swift',
    gid             => 'swift',
    max_connections => 5,
    read_only       => true,
  }

  class { 'rsync::server':
    use_xinetd => true,
    address    => $ip,
    use_chroot => 'no'
  }

}
