class havana::profiles::controller::neutron {
  anchor { 'havana::profiles::controller::neutron': }
  Class { require => Anchor['havana::profiles::controller::neutron'] }

  l2_ovs_bridge { 'br-int': ensure => present }
  l2_ovs_bridge { 'br-ex': ensure => present }

  L2_ovs_bridge<||> ~> Service<| tag == 'neutron' |>
  Package<| tag == 'neutron' |> -> L2_ovs_bridge<||>

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

}
