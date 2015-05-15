# Class: ccms_silex::service
#
# Manages the CCMS Silex Service (httpd)
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
class ccms_silex::service (
  $service_name   = $::ccms_silex::params::ccms_silex_service_name,
  $service_enable = true,
  $service_ensure = 'running',
  $service_manage = true,
  $service_restart = undef
) {

  # The base class must be included first because parameter defaults depend on it
  if ! defined(Class['ccms_silex::params']) {
    fail('You must include the ccms_silex::params class before using any ccms_silex defined resources')
  }

  validate_bool($service_enable)
  validate_bool($service_manage)

  case $service_ensure {
    true, false, 'running', 'stopped': {
      $_service_ensure = $service_ensure
    }
    default: {
      $_service_ensure = undef
    }
  }

  if $service_manage {
    service { 'silex_service':
      ensure  => $_service_ensure,
      name    => $service_name,
      enable  => $service_enable,
      restart => $service_restart
    }
  }
}