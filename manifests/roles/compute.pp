class havana::roles::compute {

  include cubbystack::repo
  include havana::users
  include havana::profiles::compute::nova
  include havana::profiles::compute::neutron
  include havana::profiles::compute::libvirt
  include havana::profiles::compute::migration_support

}
