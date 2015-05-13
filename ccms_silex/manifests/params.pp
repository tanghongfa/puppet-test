# == Class: ccms_silex::params
# 
# Parameter file used for Module: ccms_silex
#
#
class ccms_silex::params {
    #
    # The Service for CCMS Silex (httpd)
    #
    $ccms_silex_service_name = 'httpd'

    #
    # The RPM Package name for CCMS Silex component
    #
    $ccms_silex_package_name = 'foxtel-api'
}
