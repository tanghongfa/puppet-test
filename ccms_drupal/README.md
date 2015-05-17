# ccms_drupal

## Description
* This module is for Presto CCMS Drupal Component. 
* It will deploy new drupal Component if there is any and it will restart Httpd service after installation.
* Note: This Puppet Module is ONLY responsible for deploy the RPM package. The Backup, Run scripts are done via Bamboo Plan directly.

## Example
* Adding the following code to drupal Profile.
* (Note: The version should be retrived via hiera data lookup, so it can get the right version based on environment etc.)

```
class {'ccms_drupal' :
    package_version => '2.1.1'
}
```



