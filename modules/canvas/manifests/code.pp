class canvas::code($destination, $source) {

  include git

  $folder = inline_template('<%= File.dirname(destination) %>')

  file { "${folder}": ensure => directory }

  git::repo { 'canvas':
    path    => $destination,
    source  => $source,
    require => File[$folder]
  }

  exec { 'bundle':
    command => 'bundle install --path vendor/bundle --without=sqlite --without=mysql',
    creates => "${destination}/vendor/bundle",
    cwd     => $destination,
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/vagrant_ruby/bin',
    timeout => 0,
    require => Git::Repo['canvas'],
  }

  file { 'config':
    ensure => present,
    path => "${destination}/config",
    source => "puppet:///modules/canvas/config",
    recurse => remote,
    require => Git::Repo['canvas']
  }
}