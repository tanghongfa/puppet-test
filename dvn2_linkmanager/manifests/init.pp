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

    $Dimetis = 'p15.05'
    $linkmanager_service_name = 'httpd' #'linkmanager' #TODO: move to parameter file could be better in case it is required by other modules, so we don't hardcode everywhere
    $package_name = 'dimitis-linkmanager'     #TODO: move to parameter file could be better in case it is required by other modules, so we don't hardcode everywhere
    $package_url = "http://10.208.78.39:5080/content/repositories/dvn2-dev2-releases/dvn2/dimitis/dimitis-linkmanager/${Dimetis}-1/"
    $patch_cmd = '/var/tmp/apply_patch.sh' #'/opt/linkmanager/dest/patches/apply_patch.sh'
    $patch_lock_file = '/var/tmp/runpatch.lock'

    #
    # This transition module is to ensure if there is an update for the Linkmanager package, then before apply the changes, stop the linkmanager service first
    #
    transition { 'Stop LinkManager Service':
        resource   => Service[$linkmanager_service_name],
        attributes => { ensure => stopped },
        #prior_to   => Package['DVN2 Linkmanager'],
        prior_to => Exec['Install DVN2 Linkmanager'],
    }
    
    #
    # Ensure the specific verison of linkmanager package is installed.
    #
#    package { 'DVN2 Linkmanager':,
#        provider => 'rpm',
#        name => $package_name, 
#        ensure => $Dimetis,
#        install_options => [ '—oldpackage'],
#        source => $package_url,
#        notify => Exec['Apply Dimetis Patch'], #If there is an installation happenned, just notify the patch script to apply the patch
#    }

    $instalCmd = "rpm -Uvh --oldpackage http://192.168.119.1/dimitis-linkmanager-${Dimetis}-1.rpm"

    exec { "Install DVN2 Linkmanager":
        command => $instalCmd,
        path => "/bin:/usr/bin:/usr/local/bin/",
        logoutput => true,
        onlyif => [test -f /tmp/file1], #["test `rpm -qa ${package_name}` == 'dimitis-linkmanager-p16.05-1.noarch'"],
        notify => Exec['Apply Dimetis Patch'], #If there is an installation happenned, just notify the patch script to apply the patch
    }

    #
    # This command will be executed if linkmanger package is updated
    #
    exec { 'Apply Dimetis Patch':
        command   => $patch_cmd,
        path      => "/bin:/usr/bin:/usr/local/bin/",
        logoutput => true,
        creates   => $patch_lock_file,
        notify    => [File[$patch_lock_file], Service[$linkmanager_service_name]], #After the patch is applied, create a Lock file, so that the 
    }

    #
    # This is a lock file. it will be created once the patch is applied after new package is installed
    #
    file { $patch_lock_file : 
        ensure => file,
    }

    #
    # This is to ensure Linkmanager service is always running as it should be.
    #
    service { $linkmanager_service_name:
        ensure => running,
    }

}
