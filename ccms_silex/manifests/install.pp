# Class: ccms_silex::install
#
# Manages the CCMS Silex RPM (foxtel-api)
#
# Parameters:
#
# Actions:
#   - Manage Silex service
#
# Requires:
#
# Sample Usage:
#
#    sometype { 'foo':
#      notify => Class['ccms_silex::service'],
#    }
#
#
class ccms_silex::install (
    $package_name = $::ccms_silex::params::ccms_silex_package_name,
    $package_version,
    $release_version = "1",
) {

     #
        # Make sure package with specific version is installed. 
        #
        package { 'CCMS Silex RPM Package':
            name   => $package_name,
            ensure => "${package_version}-${release_version}",
            notify => Class['ccms_silex::service'],
        }

        #
        # Ensure the Serivce is running and will be refreshed if a new package is installed.        
        #
        class { '::ccms_silex::service' : }
}