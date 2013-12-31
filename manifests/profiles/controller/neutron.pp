class havana::profiles::controller::neutron {
  anchor { 'havana::profiles::controller::neutron': }
  Class { require => Anchor['havana::profiles::controller::neutron'] }

  class { 'l23network': }

  l23network::l2::bridge { 'br-int': }
  l23network::l2::bridge { 'br-ex': }

  $external_device = hiera('havana::network::external::device')
  $external_address = getvar("ipaddress_${external_device}")

  $internal_device = hiera('havana::network::internal::device')
  $internal_address = getvar("ipaddress_${internal_device}")

  class {
    'cubbystack::neutron':
      settings => hiera('havana::neutron::settings');
    'cubbystack::neutron::keystone':
      settings => hiera('havana::neutron::keystone::settings');
    'cubbystack::neutron::dhcp':
      settings => hiera('havana::neutron::dhcp::settings');
    'cubbystack::neutron::l3':
      settings => hiera('havana::neutron::l3::settings');
    'cubbystack::neutron::metadata':
      settings => hiera('havana::neutron::metadata::settings');
    'cubbystack::neutron::plugins::ovs':
      settings => hiera('havana::neutron::plugins::ovs::settings');
    'cubbystack::neutron::server':;
  }

  @@cubbystack::functions::create_mysql_db { 'neutron':
    user          => 'neutron',
    password      => hiera('havana::neutron::mysql::password'),
    allowed_hosts => hiera('havana::mysql::allowed_hosts'),
  }

  $region = hiera('havana::region')
  @@cubbystack::functions::create_keystone_endpoint { "${region}/network":
    public_url   => "http://${external_address}:9696",
    admin_url    => "http://${external_address}:9696",
    internal_url => "http://${internal_address}:9696",
    service_name => 'OpenStack Networking Service',
    tag          => $region,
  }

  @@cubbystack::functions::create_keystone_user { 'neutron':
    password => hiera('havana::neutron::keystone::password'),
    email    => 'root@localhost',
    tenant   => 'services',
    role     => 'admin',
  }

}
