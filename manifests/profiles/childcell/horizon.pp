class havana::profiles::childcell::horizon {

  anchor { 'havana::profiles::childcell::horizon': }
  Class { require => Anchor['havana::profiles::childcell::horizon'] }

  class { 'cubbystack::horizon': }

  file_line { 'horizon root url':
    path    => '/etc/apache2/conf.d/openstack-dashboard.conf',
    line    => 'WSGIScriptAlias / /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi',
    match   => 'WSGIScriptAlias ',
    require => Class['cubbystack::horizon'],
  }

}
