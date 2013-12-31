class havana::profiles::compute::neutron {

  anchor { 'havana::profiles::compute::neutron': }
  Class { require => Anchor['havana::profiles::compute::neutron'] }

  class { 'l23network': }

  l23network::l2::bridge { 'br-int': }

  class {
    'cubbystack::neutron':
      settings => hiera('havana::neutron::settings');
    'cubbystack::neutron::plugins::ovs':
      settings => hiera('havana::neutron::plugins::ovs::settings');
  }

}
