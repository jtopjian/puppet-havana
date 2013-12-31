class havana::profiles::controller::nova {

  anchor { 'havana::profiles::controller::nova': }
  Class { require => Anchor['havana::profiles::controller::nova'] }

  $external_device = hiera('havana::network::external::device')
  $external_address = getvar("ipaddress_${external_device}")

  $internal_device = hiera('havana::network::internal::device')
  $internal_address = getvar("ipaddress_${internal_device}")

  class { 'cubbystack::nova':
    settings => hiera('havana::nova::settings'),
  }
  class { 'cubbystack::nova::keystone':
    settings => hiera('havana::nova::keystone::settings'),
  }
  class { 'cubbystack::nova::db_sync': }
  class { 'cubbystack::nova::api': }
  class { 'cubbystack::nova::cert': }
  class { 'cubbystack::nova::conductor': }
  class { 'cubbystack::nova::objectstore': }
  class { 'cubbystack::nova::scheduler': }
  class { 'cubbystack::nova::vncproxy': }

  @@cubbystack::functions::create_mysql_db { 'nova':
    user          => 'nova',
    password      => hiera('havana::nova::mysql::password'),
    allowed_hosts => hiera('havana::mysql::allowed_hosts'),
  }

  $region = hiera('havana::region')
  @@cubbystack::functions::create_keystone_endpoint { "${region}/compute":
    public_url   => "http://${external_address}:8774/v2/%(tenant_id)s",
    admin_url    => "http://${external_address}:8774/v2/%(tenant_id)s",
    internal_url => "http://${internal_address}:8774/v2/%(tenant_id)s",
    service_name => 'OpenStack Compute Service',
    tag          => $region,
  }

  @@cubbystack::functions::create_keystone_endpoint { "${region}/ec2":
    public_url   => "http://${external_address}:8773/services/Cloud",
    admin_url    => "http://${external_address}:8773/services/Cloud",
    internal_url => "http://${internal_address}:8773/services/Cloud",
    service_name => 'OpenStack EC2 Service',
    tag          => $region,
  }

  @@cubbystack::functions::create_keystone_user { 'nova':
    password => hiera('havana::nova::keystone::password'),
    email    => 'root@localhost',
    tenant   => 'services',
    role     => 'admin',
  }

  ## Generate an openrc file
  ::cubbystack::functions::create_openrc { '/root/openrc':
    keystone_host        => hiera('havana::cloud_controller'),
    admin_password       => hiera('havana::keystone::admin::password'),
    admin_tenant         => 'admin',
    region               => hiera('havana::region'),
  }

}
