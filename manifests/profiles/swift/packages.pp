class havana::openstack::swift::packages {

  $packages = ['swift-plugin-s3', 'python-keystone', 'python-keystoneclient']

  package { $packages:
    ensure => latest,
  }

}
