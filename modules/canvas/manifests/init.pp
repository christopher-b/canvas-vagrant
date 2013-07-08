class canvas (
  $destination = '/var/rails/canvas',
  $source      = 'https://github.com/instructure/canvas-lms',
  $environment = 'production'
){

  # @TODO add QTIMigration tool
  # @TODO Redis?
  # @TODO Mail?

  include stdlib

  stage { 'pre':  }
  stage { 'post': }
  Stage['pre'] -> Stage['main'] -> Stage['post']

  class { 'canvas::dependencies':  stage => pre  }
  class { 'canvas::database':      stage => main }
  class { 'canvas::webserver':
    environment => $environment,
    destination => $destination,
    stage       => main,
  }
  class { 'canvas::code':
    destination => $destination,
    source      => $source,
    stage       => main
  }
  class { 'canvas::jobs':
    destination => $destination,
    require     => Class['canvas::code']
  }
  class { 'canvas::tasks':
    environment => $environment,
    destination => $destination,
    stage       => post,
  }
}