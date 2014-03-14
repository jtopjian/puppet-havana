class havana::profiles::topcell::nova {

  anchor { 'havana::profiles::topcell::nova': }
  Class { require => Anchor['havana::profiles::topcell::nova'] }

  class { 'cubbystack::nova':
    settings => hiera_hash('havana::nova::settings'),
  }

  class { 'cubbystack::nova::api': }
  class { 'cubbystack::nova::cells': }
  class { 'cubbystack::nova::conductor': }
  class { 'cubbystack::nova::db_sync': }

  ## Generate an openrc file
  cubbystack::functions::create_openrc { '/root/openrc':
    keystone_host  => hiera('havana::keystone_host'),
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
