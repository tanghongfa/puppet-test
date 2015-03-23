# == Class: dvn2_linkmanager
#
# Full description of class dvn2_linkmanager here.
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
#  class { 'dvn2_linkmanager':
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
class dvn2_linkmanager::params {
    
    #
    # Use parameter files to handle these parameters so that in case there is any other module need to use this information, they can just easy include this Parameter File
    #

    $linkmanager_service_name = 'httpd'
    #$linkmanager_service_name = 'linkmanager'

    $linkmanager_package_name = 'dimitis-linkmanager'

    #
    # Use Hiera lookup to find the Dimetis package version. It will be differ for each environment.
    #
    $linkmanager_version = hiera('linkmanager_Dimetis')

    #
    # Use Hiera lookup to find the Dimetis package Repo Name. It will be differ for each environment for now.
    #
    $linkmanager_env_repo = hiera('linkmanager_Dimetis_Repo', 'dvn2-dev2-releases')

    #
    # This is the package URL used for package installation
    # Note: This is a temp solution. 
    # Way forward:
    # Alt 1: Use RPM package management system for DVN2 systems. (prefered)
    # Alt 2: Put the base URL as hiera default level data (Important Note: It will has different value in production system, but this module will be resued in production)
    #
    #$linkmanager_package_url = "http://10.208.78.39:5080/content/repositories/${linkmanager_env_repo}/dvn2/dimitis/${linkmanager_package_name}/${linkmanager_version}-1/${linkmanager_package_name}-${linkmanager_version}-1.rpm"
    $linkmanager_package_url = "http://192.168.119.1/${linkmanager_package_name}-${linkmanager_version}-1.rpm"
}
