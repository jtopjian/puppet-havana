class havana::profiles::childcell::keystone {

  anchor { 'havana::profiles::childcell::keystone': }
  Class { require => Anchor['havana::profiles::childcell::keystone'] }

  $cloud_controller = hiera('havana::cloud_controller')
  $keystone_host = hiera('havana::keystone_host')
  $glance_host = hiera('havana::glance_host')
  $cinder_host = hiera('havana::cinder_host')
  $swift_proxy = hiera('havana::swift_proxy')
  $region = hiera('havana::region')

  class { 'cubbystack::keystone':
    settings => hiera_hash('havana::keystone::settings'),
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/identity":
    public_url   => "http://${keystone_host}:5000/v2.0",
    admin_url    => "http://${keystone_host}:35357/v2.0",
    internal_url => "http://${keystone_host}:5000/v2.0",
    service_name => 'OpenStack Identity Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/image":
    public_url   => "http://${glance_host}:9292",
    admin_url    => "http://${glance_host}:9292",
    internal_url => "http://${glance_host}:9292",
    service_name => 'OpenStack Image Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/volume":
    public_url   => "http://${cinder_host}:8776/v1/%(tenant_id)s",
    admin_url    => "http://${cinder_host}:8776/v1/%(tenant_id)s",
    internal_url => "http://${cinder_host}:8776/v1/%(tenant_id)s",
    service_name => 'OpenStack Volume Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/compute":
    public_url   => "http://${cloud_controller}:8774/v2/%(tenant_id)s",
    admin_url    => "http://${cloud_controller}:8774/v2/%(tenant_id)s",
    internal_url => "http://${cloud_controller}:8774/v2/%(tenant_id)s",
    service_name => 'OpenStack Compute Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/ec2":
    public_url   => "http://${cloud_controller}:8773/services/Cloud",
    admin_url    => "http://${cloud_controller}:8773/services/Cloud",
    internal_url => "http://${cloud_controller}:8773/services/Cloud",
    service_name => 'OpenStack EC2 Service',
    tag          => $region,
  }

  cubbystack::functions::create_keystone_endpoint { "${region}/object-store":
    public_url   => "http://${swift_proxy}:8080/v1/AUTH_%(tenant_id)s",
    admin_url    => "http://${swift_proxy}:8080",
    internal_url => "http://${swift_proxy}:8080/v1/AUTH_%(tenant_id)s",
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
