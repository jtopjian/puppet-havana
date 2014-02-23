class havana::roles::compute {

  class { 'cubbystack::repo': } ->
  class { 'havana::profiles::common::users': } ->
  class { 'havana::profiles::compute::nova': } ->
  class { 'havana::profiles::compute::neutron': }

}
