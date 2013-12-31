class havana::roles::controller {

  include cubbystack::repo
  include havana::users
  include havana::profiles::controller::memcached
  include havana::profiles::controller::mysql
  include havana::profiles::controller::rabbitmq
  include havana::profiles::controller::keystone
  include havana::profiles::controller::glance
  include havana::profiles::controller::cinder
  include havana::profiles::controller::nova
  include havana::profiles::controller::neutron
  include havana::profiles::controller::horizon

}
