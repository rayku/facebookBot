package {"redis-server":
  ensure => present,
}

service { "redis-server":
  enable     => true,
  ensure     => running,
  hasrestart => true,
  require => Package["redis-server"]
}

package {["ruby1.8", "rubygems"]:
  ensure => present,
}

package {["libxml2-dev", "libxslt1-dev"]:
  ensure => present,
}

package { "bundler":
  ensure   => installed,
  provider => "gem",
  require  => Package["rubygems"],
}

exec { "bundler":
    path => "/var/lib/gems/1.8/bin",
    command => "bundle install --without development",
    require => [ Package["libxml2-dev"], Package["libxslt1-dev"], Package["bundler"] ]
}
