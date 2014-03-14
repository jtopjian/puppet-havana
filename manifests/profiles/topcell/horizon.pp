class havana::profiles::topcell::horizon {

  anchor { 'havana::profiles::topcell::horizon': }
  Class { require => Anchor['havana::profiles::topcell::horizon'] }

  class { 'cubbystack::horizon': }

  file_line { 'horizon root url':
    path    => '/etc/apache2/conf.d/openstack-dashboard.conf',
    line    => 'WSGIScriptAlias / /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi',
    match   => 'WSGIScriptAlias ',
    require => Class['cubbystack::horizon'],
  }

}
