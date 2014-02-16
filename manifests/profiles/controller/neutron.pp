class havana::profiles::controller::neutron {
  anchor { 'havana::profiles::controller::neutron': }
  Class { require => Anchor['havana::profiles::controller::neutron'] }

  $internal_device = hiera('havana::network::internal::device')
  $internal_address = getvar("ipaddress_${internal_device}")

  $linuxbridge_settings = hiera('havana::neutron::plugins::linuxbridge::settings')
  $linuxbridge_settings['vxlan/local_ip'] = $internal_address


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
    'cubbystack::neutron::plugins::linuxbridge':
      settings => $linuxbridge_settings;
    'cubbystack::neutron::server':;
  }

}
