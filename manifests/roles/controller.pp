class havana::roles::controller {

  class { 'cubbystack::repo': } ->
  class { 'cubbystack::utils': } ->
  class { 'havana::users': } ->
  class { 'havana::profiles::controller::memcached': } ->
  class { 'havana::profiles::controller::mysql': } ->
  class { 'havana::profiles::controller::rabbitmq': } ->
  class { 'havana::profiles::controller::keystone': } ->
  class { 'havana::profiles::controller::glance': } ->
  class { 'havana::profiles::controller::nova': } ->
  class { 'havana::profiles::controller::cinder': } ->
  class { 'havana::profiles::controller::neutron': } ->
  class { 'havana::profiles::controller::horizon': }


}
