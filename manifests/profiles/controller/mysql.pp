class havana::profiles::controller::mysql {

  anchor { 'havana::profiles::controller::mysql': }
  Class { require => Anchor['havana::profiles::controller::mysql'] }

  $allowed_hosts = hiera('havana::mysql::allowed_hosts')

  $internal_device = hiera('havana::network::internal::device')
  $internal_address = getvar("ipaddress_${internal_device}")

  class { 'mysql::server':
    root_password    => hiera('havana::mysql::root_password'),
    override_options => {
      'mysqld' => {
        'bind_address' => $internal_address,
      }
    }
  }
  class { 'mysql::server::account_security': }
  class { 'mysql::bindings::python': }

  cubbystack::functions::create_mysql_db { 'keystone':
    user          => 'keystone',
    password      => hiera('havana::keystone::mysql::password'),
    allowed_hosts => hiera('havana::mysql::allowed_hosts'),
  }

  cubbystack::functions::create_mysql_db { 'glance':
    user          => 'glance',
    password      => hiera('havana::glance::mysql::password'),
    allowed_hosts => hiera('havana::mysql::allowed_hosts'),
  }

  cubbystack::functions::create_mysql_db { 'cinder':
    user          => 'cinder',
    password      => hiera('havana::cinder::mysql::password'),
    allowed_hosts => hiera('havana::mysql::allowed_hosts'),
  }

  cubbystack::functions::create_mysql_db { 'nova':
    user          => 'nova',
    password      => hiera('havana::nova::mysql::password'),
    allowed_hosts => hiera('havana::mysql::allowed_hosts'),
  }

  cubbystack::functions::create_mysql_db { 'neutron':
    user          => 'neutron',
    password      => hiera('havana::neutron::mysql::password'),
    allowed_hosts => hiera('havana::mysql::allowed_hosts'),
  }

}
