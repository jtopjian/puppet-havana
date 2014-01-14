class havana::profiles::swift::rsync {

  anchor { 'havana::profiles::swift::rsync': }
  Class { require => Anchor['havana::profiles::swift::rsync'] }

  # Determine the IP address
  $interface = hiera('havana::network::internal::device')
  $ip = getvar("ipaddress_${interface}")

  class { 'rsync::server':
    use_xinetd => true,
    address    => $ip,
    use_chroot => 'no'
  }

}
