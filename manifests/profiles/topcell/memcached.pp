class havana::profiles::topcell::memcached {

  anchor { 'havana::profiles::topcell::memcached': }
  Class { require => Anchor['havana::profiles::topcell::memcached'] }

  class { '::memcached':
    listen_ip => '127.0.0.1',
  }

  #$packages = ['python-memcache']
  #package { $packages:
  #  ensure => latest,
  #}

}
