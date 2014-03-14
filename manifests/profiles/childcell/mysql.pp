class havana::profiles::childcell::mysql {

  anchor { 'havana::profiles::childcell::mysql': }
  Class { require => Anchor['havana::profiles::childcell::mysql'] }

  $allowed_hosts = hiera_array('havana::mysql::allowed_hosts')

  class { 'mysql::server':
    root_password           => hiera('havana::mysql::root_password'),
    remove_default_accounts => true,
    override_options        => {
      'mysqld' => {
        'bind_address' => '0.0.0.0',
      }
    }
  }

  include mysql::bindings
  include mysql::bindings::python

  cubbystack::functions::create_mysql_db { 'nova':
    user          => 'nova',
    password      => hiera('havana::nova::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

}
