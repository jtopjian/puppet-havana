class havana::profiles::swift::rings {

  anchor { 'havana::profiles::swift::rings': }
  Class { require => Anchor['havana::profiles::swift::rings'] }

  # manage the rings
  Ring_object_device    <<| tag == $::location |>>
  Ring_container_device <<| tag == $::location |>>
  Ring_account_device   <<| tag == $::location |>>
  class { 'cubbystack::swift::rings':
    part_power     => hiera('havana::swift::swift_part_power'),
    replicas       => hiera('havana::swift::swift_replicas'),
    min_part_hours => hiera('havana::swift::swift_min_part_hours'),
  }

}
