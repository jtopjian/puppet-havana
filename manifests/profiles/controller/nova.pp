class havana::profiles::controller::nova {

  anchor { 'havana::profiles::controller::nova': }
  Class { require => Anchor['havana::profiles::controller::nova'] }

  class { 'cubbystack::nova':
    settings => hiera('havana::nova::settings'),
  }
  class { 'cubbystack::nova::keystone':
    settings => hiera('havana::nova::keystone::settings'),
  }
  class { 'cubbystack::nova::api': }
  class { 'cubbystack::nova::cert': }
  class { 'cubbystack::nova::conductor': }
  class { 'cubbystack::nova::objectstore': }
  class { 'cubbystack::nova::scheduler': }
  class { 'cubbystack::nova::vncproxy': }
  class { 'cubbystack::nova::db_sync': }

  ## Generate an openrc file
  cubbystack::functions::create_openrc { '/root/openrc':
    keystone_host  => hiera('havana::cloud_controller'),
    admin_password => hiera('havana::keystone::admin::password'),
    admin_tenant   => 'admin',
    region         => hiera('havana::region'),
  }

  ## Copy the prep file
  file { '/root/prep.sh':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
    source => 'puppet:///modules/havana/prep.sh',
  }

}
