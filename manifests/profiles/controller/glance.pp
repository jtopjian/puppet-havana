class havana::profiles::controller::glance {
  anchor { 'havana::profiles::controller::glance': }
  Class { require => Anchor['havana::profiles::controller::glance'] }

  class { 'cubbystack::glance': }
  class { 'cubbystack::glance::api':
    settings => hiera('havana::glance::api::settings'),
  }
  class { 'cubbystack::glance::registry':
    settings => hiera('havana::glance::registry::settings'),
  }
  class { 'cubbystack::glance::cache':
    settings => hiera('havana::glance::cache::settings'),
  }
  class { 'cubbystack::glance::db_sync': }

}
