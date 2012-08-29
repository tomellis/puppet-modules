# Class: keepalived::server
#
# This class manage keepalived server installation and configuration. 
#
class keepalived::server {

  include concat::setup

  package { keepalived: ensure => installed }

  service { keepalived:
    ensure => running,
    enable => true,
    require => [ Package["keepalived"], Concat['/etc/keepalived/keepalived.conf'], ],
  }

  # Simple Header
  concat::fragment { '00-keepalived/keepalived.conf':
    target  => '/etc/keepalived/keepalived.conf',
    order   => '01',
    content => "# This file managed by Puppet\n",
  }

  concat::fragment { "${name}_keepalived_header":
    order   => '10',
    target  => '/etc/keepalived/keepalived.conf',
    content => template('keepalived/keepalived.conf.header.erb'),
  }

  concat { '/etc/keepalived/keepalived.conf':
    owner   => '0',
    group   => '0',
    mode    => '0644',
    require => Package['keepalived'],
    notify  => Service['keepalived'],
  }
}
