class havana::profiles::topcell::keystone {

  anchor { 'havana::profiles::topcell::keystone': }
  Class { require => Anchor['havana::profiles::topcell::keystone'] }

  $external_address = hiera('network::external::ip')
  $internal_address = hiera('network::internal::ip')

  class { 'cubbystack::keystone':
    settings => hiera_hash('havana::keystone::settings'),
  }

  $region = hiera('havana::region')
  cubbystack::functions::create_keystone_endpoint { "${region}/identity":
    public_url   => "http://${external_address}:5000/v2.0",
    admin_url    => "http://${external_address}:35357/v2.0",
    internal_url => "http://${internal_address}:5000/v2.0",
    service_name => 'OpenStack Identity Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/image":
    public_url   => "http://${external_address}:9292",
    admin_url    => "http://${external_address}:9292",
    internal_url => "http://${internal_address}:9292",
    service_name => 'OpenStack Image Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/volume":
    public_url   => "http://${external_address}:8776/v1/%(tenant_id)s",
    admin_url    => "http://${external_address}:8776/v1/%(tenant_id)s",
    internal_url => "http://${internal_address}:8776/v1/%(tenant_id)s",
    service_name => 'OpenStack Volume Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/compute":
    public_url   => "http://${external_address}:8774/v2/%(tenant_id)s",
    admin_url    => "http://${external_address}:8774/v2/%(tenant_id)s",
    internal_url => "http://${internal_address}:8774/v2/%(tenant_id)s",
    service_name => 'OpenStack Compute Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/ec2":
    public_url   => "http://${external_address}:8773/services/Cloud",
    admin_url    => "http://${external_address}:8773/services/Cloud",
    internal_url => "http://${internal_address}:8773/services/Cloud",
    service_name => 'OpenStack EC2 Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/object-store":
    public_url   => "http://${external_address}:8080/v1/AUTH_%(tenant_id)s",
    admin_url    => "http://${external_address}:8080",
    internal_url => "http://${internal_address}:8080/v1/AUTH_%(tenant_id)s",
    service_name => 'OpenStack Object Storage Service',
    tag          => $region,
  }

  keystone_tenant { 'admin':
    ensure      => present,
    description => 'Admin Tenant',
  }

  keystone_tenant { 'services':
    ensure      => present,
    description => 'Tenant for the OpenStack services',
  }

  keystone_role { 'admin':
    ensure => present,
  }

  cubbystack::functions::create_keystone_user { 'admin':
    password => hiera('havana::keystone::admin::password'),
    email    => 'root@localhost',
    tenant   => 'admin',
    role     => 'admin',
  }

  cubbystack::functions::create_keystone_user { 'glance':
    password => hiera('havana::glance::keystone::password'),
    email    => 'root@localhost',
    tenant   => 'services',
    role     => 'admin',
  }

  cubbystack::functions::create_keystone_user { 'cinder':
    password => hiera('havana::cinder::keystone::password'),
    email    => 'root@localhost',
    tenant   => 'services',
    role     => 'admin',
  }

  cubbystack::functions::create_keystone_user { 'nova':
    password => hiera('havana::nova::keystone::password'),
    email    => 'root@localhost',
    tenant   => 'services',
    role     => 'admin',
  }

  cubbystack::functions::create_keystone_user { 'swift':
    password => hiera('havana::swift::keystone::password'),
    email    => 'root@localhost',
    tenant   => 'services',
    role     => 'admin',
  }

}
