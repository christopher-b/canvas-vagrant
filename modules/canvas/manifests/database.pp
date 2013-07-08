class canvas::database {
  include postgresql::server

  Postgresql::Db {
    user     => 'canvas',
    password => 'canvas',
  }

  postgresql::db { 'canvas': }
  postgresql::db { 'canvas_queue': }
  postgresql::db { 'canvas_development': }
  postgresql::db { 'canvas_queue_development': }
  postgresql::db { 'canvas_test': }
}