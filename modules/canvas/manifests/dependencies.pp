class canvas::dependencies {

  file { 'init-script':
    ensure => present,
    source => 'puppet:///modules/canvas/init.sh',
    path   => '/tmp/init.sh',
    mode   => 0744
  }

  exec { 'init-script':
    command => '/tmp/init.sh',
    creates => '/root/init_done',
    require => File['init-script'],
  }

  package {
    [
      'ruby1.9.3',
      'nodejs',
      'git-core',
      'build-essential',
      'imagemagick',
      'libcurl4-gnutls-dev',
      'libpq-dev',
      'libsqlite3-dev',
      'libxmlsec1',
      'libxml2-dev',
      'libxmlsec1-dev',
      'libxslt1-dev',
      'zlib1g-dev',
      'passenger-common1.9.1',
      'libapache2-mod-passenger',
      'apache2',
    ]:
      ensure => present,
      require => Exec['init-script']
  }

  package { 'bundler':
      ensure   => 'installed',
      provider => 'gem',
      require  => Package['ruby1.9.3']
  }

  a2enmod { 'rewrite': }
  a2enmod { 'ssl': }
  a2enmod { 'passenger': require => [Package['passenger-common1.9.1'], Package['libapache2-mod-passenger']] }

  define a2enmod ($mod = $title) {
    exec { "a2enmod-${mod}":
      command => "/usr/sbin/a2enmod ${mod}",
      creates => "/etc/apache2/mods-enabled/${mod}.load",
      require => [Package['apache2']]
    }
  }

}