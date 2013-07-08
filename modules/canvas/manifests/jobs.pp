class canvas::jobs($destination) {

  file {'jobs-script':
    ensure => link,
    path   => '/etc/init.d/canvas_init',
    target => "${destination}/script/canvas_init"
  }

  service { 'jobs-daemon':
    name => 'canvas_init',
    ensure => running,
    enable => true,
    require => File['jobs-script']
  }

}