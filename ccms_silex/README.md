# ccms_silex

## Description
This module is for Presto CCMS Silex Component. 
It will deploy new Silex Component if there is any and it will restart Httpd service after installation.
Note: It will NOT taking backup before installation, and it will NOT restart Vanish Applications after installation. These parts are done via Bamboo Plan.

## Example
Adding the following code to Silex Profile.
(Note: The version should be retrived via hiera data lookup, so it can get the right version based on environment etc.)


```
class {'ccms_silex' :
    package_version => '2.1.1'
}
```



