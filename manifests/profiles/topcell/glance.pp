class havana::profiles::topcell::glance {
  anchor { 'havana::profiles::topcell::glance': }
  Class { require => Anchor['havana::profiles::topcell::glance'] }

  class { 'cubbystack::glance': }
  class { 'cubbystack::glance::api':
    settings => hiera_hash('havana::glance::api::settings'),
  }
  class { 'cubbystack::glance::registry':
    settings => hiera_hash('havana::glance::registry::settings'),
  }
  class { 'cubbystack::glance::cache':
    settings => hiera_hash('havana::glance::cache::settings'),
  }
  class { 'cubbystack::glance::db_sync': }

}
