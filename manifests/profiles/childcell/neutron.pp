class havana::profiles::childcell::neutron {
  anchor { 'havana::profiles::childcell::neutron': }
  Class { require => Anchor['havana::profiles::childcell::neutron'] }

  $internal_address = hiera('network::internal::ip')
  $linuxbridge_settings = hiera_hash('havana::neutron::plugins::linuxbridge::settings')

  # Determine the internal address for vxlan
  $vxlan = { 'vxlan/local_ip' => $internal_address }

  # merge the two settings
  $linuxbridge_merged = merge($linuxbridge_settings, $vxlan)

  # Fix default neutron config for ubuntu
  case $::lsbdistid {
    'Ubuntu': {
      file_line { '/etc/default/neutron-server NEUTRON_PLUGIN_CONFIG':
        path  => '/etc/default/neutron-server',
        line  => 'NEUTRON_PLUGIN_CONFIG="/etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini',
        match => '^NEUTRON_PLUGIN_CONFIG'
      }
    }
  }

  class {
    'cubbystack::neutron':
      settings => hiera_hash('havana::neutron::settings');
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
