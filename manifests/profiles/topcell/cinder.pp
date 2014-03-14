class havana::profiles::topcell::cinder {
  anchor { 'havana::profiles::topcell::cinder': }
  Class { require => Anchor['havana::profiles::topcell::cinder'] }

  class { 'cubbystack::cinder':
    settings => hiera_hash('havana::cinder::settings'),
  }

  class { 'cubbystack::cinder::api': }
  class { 'cubbystack::cinder::scheduler': }
  class { 'cubbystack::cinder::volume': }
  class { 'cubbystack::cinder::db_sync': }

}
