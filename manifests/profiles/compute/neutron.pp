class havana::profiles::compute::neutron {

  anchor { 'havana::profiles::compute::neutron': }
  Class { require => Anchor['havana::profiles::compute::neutron'] }

  l2_ovs_bridge { 'br-int': ensure => present }

  L2_ovs_bridge<||> ~> Service<| tag == 'neutron' |>
  Package<| tag == 'neutron' |> -> L2_ovs_bridge<||>

  class {
    'cubbystack::neutron':
      settings => hiera('havana::neutron::settings');
    'cubbystack::neutron::plugins::ovs':
      settings => hiera('havana::neutron::plugins::ovs::settings');
  }

}
