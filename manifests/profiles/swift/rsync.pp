class havana::profiles::swift::rsync {

  anchor { 'havana::profiles::swift::rsync': }
  Class { require => Anchor['havana::profiles::swift::rsync'] }

  # Determine the IP address
  $ip = hiera('network::internal::ip')

  class { 'rsync::server':
    use_xinetd => true,
    address    => $ip,
    use_chroot => 'no'
  }

}
