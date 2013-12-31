class havana::profiles::controller::keystone {

  anchor { 'havana::profiles::controller::keystone': }
  Class { require => Anchor['havana::profiles::controller::keystone'] }

  $external_device = hiera('havana::network::external::device')
  $external_address = getvar("ipaddress_${external_device}")

  $internal_device = hiera('havana::network::internal::device')
  $internal_address = getvar("ipaddress_${internal_device}")

  class { 'cubbystack::keystone':
    settings => hiera('havana::keystone::settings'),
  }

  cubbystack::functions::create_mysql_db { 'keystone':
    user          => 'keystone',
    password      => hiera('havana::keystone::mysql::password'),
    allowed_hosts => hiera('havana::mysql::allowed_hosts'),
  }

  $region = hiera('havana::region')
  cubbystack::functions::create_keystone_endpoint { "${region}/identity":
    public_url   => "http://${external_address}:5000/v2.0",
    admin_url    => "http://${external_address}:35357/v2.0",
    internal_url => "http://${internal_address}:5000/v2.0",
    service_name => 'OpenStack Identity Service',
    tag          => $region,
  }

  keystone_tenant { 'admin':
    description => 'Admin Tenant',
  }

  keystone_tenant { 'services':
    description => 'Tenant for the OpenStack services',
  }

  keystone_role { 'admin': }

  cubbystack::functions::create_keystone_user { 'admin':
    password => hiera('havana::keystone::admin::password'),
    email    => 'root@localhost',
    tenant   => 'admin',
    role     => 'admin',
    require  => [Keystone_tenant['admin'], Keystone_role['admin']],
  }

  Cubbystack::Functions::Create_keystone_endpoint<<||>>
  Cubbystack::Functions::Create_keystone_user<<||>>

}
