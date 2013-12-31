class havana::profiles::controller::memcached {

  anchor { 'havana::profiles::controller::memcached': }
  Class { require => Anchor['havana::profiles::controller::memcached'] }

  class { '::memcached':
    listen_ip => '127.0.0.1',
  }

  #$packages = ['python-memcache']
  #package { $packages:
  #  ensure => latest,
  #}

}
