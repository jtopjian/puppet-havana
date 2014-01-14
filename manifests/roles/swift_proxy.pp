class havana::roles::swift_proxy {

  anchor { 'havana::roles::swift_proxy': }
  Class { require => Anchor['havana::roles::swift_proxy'] }

  class { 'havana::profiles::common::users': } ->
  class { 'havana::profiles::common::memcached': } ->
  class { 'cubbystack::swift':
    settings => hiera('havana::swift::settings'),
  } ->
  class { 'havana::profiles::swift::rsync': } ->
  class { 'havana::profiles::swift::rings': } ->
  class { 'cubbystack::swift::proxy':
    settings => hiera('havana::swift::proxy::settings'),
  }

}
