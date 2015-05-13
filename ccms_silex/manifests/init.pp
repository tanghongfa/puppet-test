# == Class: ccms_silex
#
# Full description of class ccms_silex here.
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
#  class { 'ccms_silex':
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
class ccms_silex (
    $service_name = $::ccms_silex::params::ccms_silex_service_name,
    $package_name = $::ccms_silex::params::ccms_silex_package_name,
    $package_version
) inherits ::ccms_silex::params
{
        #
        # Make sure package with specific version is installed. If not, install it and notify to restart the service
        #
        package { 'CCMS Silex RPM Package':
            name => $package_name,
            ensure => $package_version,
            notify => Serivce[$service_name]
        }

        #
        # Ensure the Serivce is running
        #
        service { $service_name :
            ensure => 'running'
        }

}
