class havana::profiles::common::memcached {

  anchor { 'havana::profiles::common::memcached': }
  Class { require => Anchor['havana::profiles::common::memcached'] }

  class { '::memcached':
    listen_ip => '127.0.0.1',
  }

  case $::operatingsystem {
    'Ubuntu': {
      package { 'python-memcache':
        ensure => latest,
      }
    }
  }

}
