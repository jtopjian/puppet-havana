class havana::roles::compute {

  class { 'cubbystack::repo': } ->
  class { 'cubbystack::utils': } ->
  class { 'havana::profiles::common::users': } ->
  class { 'havana::profiles::common::ovs': } ->
  class { 'havana::profiles::compute::nova': } ->
  class { 'havana::profiles::compute::migration_support': } ->
  class { 'havana::profiles::compute::neutron': }

}
