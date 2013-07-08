class canvas::tasks($environment, $destination) {

  Exec {
    cwd         => $destination,
    environment => "RAILS_ENV=${environment}"
  }

  exec { 'compile-assets':
    command => "/usr/local/bin/bundle exec rake canvas:compile_assets",
    creates => "${destination}/public/assets",
    timeout => 0
  }

  notify{ 'complete':
    message => "Setup complete! Please run `vagrant ssh`, `sudo su`, then `cd ${destination} && RAILS_ENV=${environment} bundle exec rake db:initial_setup`",
    require => Exec['compile-assets']
  }

  file { 'post-script':
    ensure => file,
    path   => '/tmp/post.sh',
    content => template("canvas/post.sh.erb"),
    mode   => 0744
  }

  exec { 'post-script':
    command => '/tmp/post.sh',
    creates => '/root/post_done',
    require => [File['post-script'], Exec['compile-assets']]
  }

}