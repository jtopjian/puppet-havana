class havana::profiles::childcell::memcached {

  anchor { 'havana::profiles::childcell::memcached': }
  Class { require => Anchor['havana::profiles::childcell::memcached'] }

  class { '::memcached':
    listen_ip => '127.0.0.1',
  }

  #$packages = ['python-memcache']
  #package { $packages:
  #  ensure => latest,
  #}

}
