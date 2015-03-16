# == Class: runpatch
#
# Full description of class runpatch here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'runpatch':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class runpatch {

    $lock_file = '/var/tmp/runpatch.lock'

    exec { "apply_patch":
      command => "/var/tmp/runpatch.sh",
      path    => "/usr/local/bin/:/bin/",
      logoutput => true,
      creates => $lock_file,
      notify => File[$lock_file],
    }

    file { $lock_file : 
       ensure => file,
    }
}
