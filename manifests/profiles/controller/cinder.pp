class havana::profiles::controller::cinder {
  anchor { 'havana::profiles::controller::cinder': }
  Class { require => Anchor['havana::profiles::controller::cinder'] }

  $external_device = hiera('havana::network::external::device')
  $external_address = getvar("ipaddress_${external_device}")

  $internal_device = hiera('havana::network::internal::device')
  $internal_address = getvar("ipaddress_${internal_device}")

  class { 'cubbystack::cinder':
    settings => hiera('havana::cinder::settings'),
  }
  class { 'cubbystack::cinder::keystone':
    settings => hiera('havana::cinder::keystone::settings'),
  }
  class { 'cubbystack::cinder::db_sync': }
  class { 'cubbystack::cinder::api': }
  class { 'cubbystack::cinder::scheduler': }
  class { 'cubbystack::cinder::volume': }

  @@cubbystack::functions::create_mysql_db { 'cinder':
    user          => 'cinder',
    password      => hiera('havana::cinder::mysql::password'),
    allowed_hosts => hiera('havana::mysql::allowed_hosts'),
  }

  $region = hiera('havana::region')
  @@cubbystack::functions::create_keystone_endpoint { "${region}/volume":
    public_url   => "http://${external_address}:8776/v1/%(tenant_id)s",
    admin_url    => "http://${external_address}:8776/v1/%(tenant_id)s",
    internal_url => "http://${internal_address}:8776/v1/%(tenant_id)s",
    service_name => 'OpenStack Volume Service',
    tag          => $region,
  }

  @@cubbystack::functions::create_keystone_user { 'cinder':
    password => hiera('havana::cinder::keystone::password'),
    email    => 'root@localhost',
    tenant   => 'services',
    role     => 'admin',
  }

}
