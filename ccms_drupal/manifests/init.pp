# == Class: ccms_drupal
#
# Full description of class ccms_drupal here.
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
#  class { 'ccms_drupal':
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
class ccms_drupal (
    $package_name = $::ccms_drupal::params::ccms_drupal_package_name,
    $package_version
) inherits ::ccms_drupal::params
{
        #
        # Make sure package with specific version is installed. 
        #
        package { 'CCMS drupal RPM Package':
            name   => $package_name,
            ensure => $package_version,
        }
}
