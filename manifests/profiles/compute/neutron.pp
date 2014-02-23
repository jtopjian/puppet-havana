class havana::profiles::compute::neutron {

  anchor { 'havana::profiles::compute::neutron': }
  Class { require => Anchor['havana::profiles::compute::neutron'] }

  $internal_device = hiera('havana::network::internal::device')
  $internal_address = getvar("ipaddress_${internal_device}")

  $linuxbridge_settings = hiera_hash('havana::neutron::plugins::linuxbridge::settings')

  # Determine the internal address for vxlan
  $vxlan = { 'vxlan/local_ip' => $internal_address }

  # merge the two settings
  $linuxbridge_merged = merge($linuxbridge_settings, $vxlan)

  class {
    'cubbystack::neutron':
      settings => hiera('havana::neutron::settings');
    'cubbystack::neutron::plugins::linuxbridge':
      settings => $linuxbridge_merged;
  }

}
