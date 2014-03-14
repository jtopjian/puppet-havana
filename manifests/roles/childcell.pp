class havana::roles::childcell {

  class { 'cubbystack::repo': } ->
  class { 'havana::profiles::common::users': } ->
  class { 'havana::profiles::common::memcached': } ->
  class { 'havana::profiles::childcell::mysql': } ->
  class { 'havana::profiles::childcell::rabbitmq': } ->
  class { 'havana::profiles::childcell::nova': }

}
