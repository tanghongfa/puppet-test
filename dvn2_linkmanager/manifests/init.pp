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
class dvn2_linkmanager {

    include dvn2_linkmanager::params

    $patch_cmd = '/var/tmp/apply_patch.sh' 
    #patch_cmd = '/opt/linkmanager/dest/patches/apply_patch.sh'
    $patch_lock_file = '/var/tmp/runpatch.lock'
    $package_install_cmd = "rpm -Uvh --oldpackage ${dvn2_linkmanager::params::linkmanager_package_url}"

    #
    # This transition module is to ensure Service will be stopped before apply any new/old Linkmanager packages
    #
    transition { 'Stop LinkManager Service':
        resource   => Service[$dvn2_linkmanager::params::linkmanager_service_name],
        attributes => { ensure => stopped },        
        prior_to => Exec['Install DVN2 Linkmanager'],
    }
    
    #
    # Using Exec to install the package. This is due to YUM package system is not available on DVN2 SUSE env.
    #
    exec { "Install DVN2 Linkmanager":
        command => $package_install_cmd,
        path => "/bin:/usr/bin:/usr/local/bin/",
        logoutput => true,        
        onlyif => "rpm -q ${dvn2_linkmanager::params::linkmanager_package_name}-${dvn2_linkmanager::params::linkmanager_version}-1.noarch >/dev/null; test `echo $?` != \"0\"",
        before => Exec['Apply Dimetis Patch'], #Make sure patch will always be applied after package is installed
    }

    #
    # This command will be executed if linkmanger package is updated
    #
    exec { 'Apply Dimetis Patch':
        command   => $patch_cmd,
        path      => "/bin:/usr/bin:/usr/local/bin/",
        logoutput => true,
        creates   => $patch_lock_file,
        notify    => [File[$patch_lock_file], Service[$dvn2_linkmanager::params::linkmanager_service_name]], #After the patch is applied, create a Lock file, so that the 
    }

    #
    # This is a lock file. it will be created once the patch is applied after new package is installed
    # Note: this script will make sure the lock file is always there (it will only be deleted by the RPM package when installing a new RPM)
    #
    file { $patch_lock_file : 
        ensure => file,
    }

    #
    # This is to ensure Linkmanager service is always running as it should be.
    #
    service { $dvn2_linkmanager::params::linkmanager_service_name:
        ensure => running,
    }

}
