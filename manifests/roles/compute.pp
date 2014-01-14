class havana::roles::compute {

  class { 'cubbystack::repo': } ->
  class { 'havana::common::users': } ->
  class { 'havana::profiles::compute::nova': } ->
  class { 'havana::profiles::compute::neutron': }

}
