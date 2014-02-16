class havana::profiles::compute::neutron {

  anchor { 'havana::profiles::compute::neutron': }
  Class { require => Anchor['havana::profiles::compute::neutron'] }

  $internal_device = hiera('havana::network::internal::device')
  $internal_address = getvar("ipaddress_${internal_device}")

  $linuxbridge_settings = hiera('havana::neutron::plugins::linuxbridge::settings')
  $linuxbridge_settings['vxlan/local_ip'] = $internal_address


  class {
    'cubbystack::neutron':
      settings => hiera('havana::neutron::settings');
    'cubbystack::neutron::plugins::linuxbridge':
      settings => $linuxbridge_settings;
  }

}
