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
    $package_name,
    $package_version,
    $release_version,
) {
        notify {$package_name:}
        notify {"${package_version}-${release_version}" :}
        #
        # Make sure package with specific version is installed. 
        #
        package { 'CCMS Silex RPM Package':
            name   => $package_name,
            ensure => "${package_version}-${release_version}",
            notify => Class['ccms_silex::service'],
        }

}
