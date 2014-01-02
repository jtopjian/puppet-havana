class havana::profiles::controller::horizon {

  anchor { 'havana::profiles::controller::horizon': }
  Class { require => Anchor['havana::profiles::controller::horizon'] }

  class { 'cubbystack::horizon': }

  file_line { 'horizon root url':
    path    => '/etc/apache2/conf.d/openstack-dashboard.conf',
    line    => 'WSGIScriptAlias / /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi',
    match   => 'WSGIScriptAlias ',
    require => Class['cubbystack::horizon'],
  }

}
