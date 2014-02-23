class havana::profiles::controller::cinder {
  anchor { 'havana::profiles::controller::cinder': }
  Class { require => Anchor['havana::profiles::controller::cinder'] }

  class { 'cubbystack::cinder':
    settings => hiera_hash('havana::cinder::settings'),
  }
  class { 'cubbystack::cinder::keystone':
    settings => hiera_hash('havana::cinder::keystone::settings'),
  }
  class { 'cubbystack::cinder::api': }
  class { 'cubbystack::cinder::scheduler': }
  class { 'cubbystack::cinder::volume': }
  class { 'cubbystack::cinder::db_sync': }

}
