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

  Cubbystack::Functions::Create_mysql_db<<||>>

}
