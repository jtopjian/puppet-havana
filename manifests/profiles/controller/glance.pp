class havana::profiles::controller::glance {
  anchor { 'havana::profiles::controller::glance': }
  Class { require => Anchor['havana::profiles::controller::glance'] }

  $external_device = hiera('havana::network::external::device')
  $external_address = getvar("ipaddress_${external_device}")

  $internal_device = hiera('havana::network::internal::device')
  $internal_address = getvar("ipaddress_${internal_device}")

  class { 'cubbystack::glance': }
  class { 'cubbystack::glance::db_sync': }
  class { 'cubbystack::glance::api':
    settings => hiera('havana::glance::api::settings'),
  }
  class { 'cubbystack::glance::registry':
    settings => hiera('havana::glance::registry::settings'),
  }
  class { 'cubbystack::glance::cache':
    settings => hiera('havana::glance::cache::settings'),
  }

  @@cubbystack::functions::create_mysql_db { 'glance':
    user          => 'glance',
    password      => hiera('havana::glance::mysql::password'),
    allowed_hosts => hiera('havana::mysql::allowed_hosts'),
  }

  $region = hiera('havana::region')
  @@cubbystack::functions::create_keystone_endpoint { "${region}/image":
    public_url   => "http://${external_address}:9292",
    admin_url    => "http://${external_address}:9292",
    internal_url => "http://${internal_address}:9292",
    service_name => 'OpenStack Image Service',
    tag          => $region,
  }

  @@cubbystack::functions::create_keystone_user { 'glance':
    password => hiera('havana::glance::keystone::password'),
    email    => 'root@localhost',
    tenant   => 'services',
    role     => 'admin',
  }

}
