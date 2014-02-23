class havana::profiles::controller::neutron {
  anchor { 'havana::profiles::controller::neutron': }
  Class { require => Anchor['havana::profiles::controller::neutron'] }

  $internal_device = hiera('havana::network::internal::device')
  $internal_address = getvar("ipaddress_${internal_device}")

  $linuxbridge_settings = hiera_hash('havana::neutron::plugins::linuxbridge::settings')

  # Determine the internal address for vxlan
  $vxlan = { 'vxlan/local_ip' => $internal_address }

  # merge the two settings
  $linuxbridge_merged = merge($linuxbridge_settings, $vxlan)

  class {
    'cubbystack::neutron':
      settings => hiera_hash('havana::neutron::settings');
    'cubbystack::neutron::keystone':
      settings => hiera_hash('havana::neutron::keystone::settings');
    'cubbystack::neutron::dhcp':
      settings => hiera_hash('havana::neutron::dhcp::settings');
    'cubbystack::neutron::l3':
      settings => hiera_hash('havana::neutron::l3::settings');
    'cubbystack::neutron::metadata':
      settings => hiera_hash('havana::neutron::metadata::settings');
    'cubbystack::neutron::plugins::linuxbridge':
      settings => $linuxbridge_merged;
    'cubbystack::neutron::server':;
  }

}
