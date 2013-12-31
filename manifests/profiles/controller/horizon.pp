class havana::profiles::controller::horizon {

  include cubbystack::horizon

  # Packages required by Horizon
  $horizon_packages = ['python-django', 'python-compressor', 'python-appconf', 'python-cloudfiles', 'python-tz', 'node-less']
  package { $horizon_packages:
    ensure => latest,
  }

  file_line { 'horizon root url':
    path    => '/etc/apache2/conf.d/openstack-dashboard.conf',
    line    => 'WSGIScriptAlias / /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi',
    match   => 'WSGIScriptAlias ',
    require => Class['cubbystack::horizon'],
  }

}
