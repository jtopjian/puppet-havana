class havana::roles::topcell {

  class { 'cubbystack::repo': } ->
  class { 'havana::profiles::common::users': } ->
  class { 'havana::profiles::common::memcached': } ->
  class { 'havana::profiles::topcell::mysql': } ->
  class { 'havana::profiles::topcell::rabbitmq': } ->
  class { 'havana::profiles::topcell::keystone': } ->
  class { 'havana::profiles::topcell::glance': } ->
  class { 'havana::profiles::topcell::cinder': } ->
  class { 'havana::profiles::topcell::nova': } ->
  class { 'havana::profiles::topcell::horizon': }

}
