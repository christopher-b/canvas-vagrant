class canvas::webserver($environment, $destination) {
  file { 'vhost-config':
    path    => '/etc/apache2/sites-available/canvas',
    ensure  => file,
    content => template("canvas/canvas-vhost.conf.erb"),
    require => Package['apache2'],
  }

  exec { 'enable-site':
    command => '/usr/sbin/a2ensite canvas',
    creates => '/etc/apache2/sites-enabled/canvas',
    require => File['vhost-config']
  }

  service { 'apache2':
    ensure  => running,
    enable  => true,
    require => Exec['enable-site']
  }

  file { 'default-vhost':
    path   => '/etc/apache2/sites-enabled/000-default',
    ensure => absent,
    notify => Service['apache2']
  }

  # file { 'site-enable':
  #   path => '/etc/apache2/site-enabled'
  # }
}