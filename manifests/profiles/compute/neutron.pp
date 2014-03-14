class havana::profiles::compute::neutron {

  anchor { 'havana::profiles::compute::neutron': }
  Class { require => Anchor['havana::profiles::compute::neutron'] }

  # Get the internal IP of the compute node
  $internal_address = hiera('network::internal::ip')

  # Determine the internal address for vxlan
  $vxlan = { 'vxlan/local_ip' => $internal_address }

  # merge the two settings
  $linuxbridge_settings = hiera_hash('havana::neutron::plugins::linuxbridge::settings')
  $linuxbridge_merged = merge($linuxbridge_settings, $vxlan)

  class {
    'cubbystack::neutron':
      settings => hiera_hash('havana::neutron::settings');
    'cubbystack::neutron::plugins::linuxbridge':
      settings => $linuxbridge_merged;
  }

}
