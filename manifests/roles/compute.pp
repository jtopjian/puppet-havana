class havana::roles::compute {

  class { 'cubbystack::repo': } ->
  class { 'cubbystack::utils': } ->
  class { 'havana::users': } ->
  class { 'havana::profiles::compute::nova': } ->
  class { 'havana::profiles::compute::neutron': }

}
