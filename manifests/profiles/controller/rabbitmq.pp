class havana::profiles::controller::rabbitmq {

  anchor { 'havana::profiles::controller::rabbitmq': }
  Class { require => Anchor['havana::profiles::controller::rabbitmq'] }

  $userid   = hiera('havana::rabbitmq::userid')
  $password = hiera('havana::rabbitmq::password')

  class { '::rabbitmq::server':
    delete_guest_user => true,
  }

  rabbitmq_user { $userid:
    admin    => true,
    password => $password,
    require  => Class['::rabbitmq::server'],
  }

  rabbitmq_user_permissions { "${userid}@/":
    configure_permission => '.*',
    write_permission     => '.*',
    read_permission      => '.*',
  }

  rabbitmq_vhost { '/':
    require => Class['::rabbitmq::server'],
  }

}
