# /etc/puppetlabs/puppet/modules/mco_plugins/manifests/puppetsyncrun.pp
class mco_plugins::puppetsyncrun {
  include puppet_enterprise::params
  $plugin_basedir = $puppet_enterprise::params::mco_plugin_basedir
  $mco_etc        = $puppet_enterprise::params::mco_etc

  #File {
  #  owner => $puppet_enterprise::params::root_owner,
  #  group => $puppet_enterprise::params::root_group,
  #  mode  => $puppet_enterprise::params::root_mode,
  #}

  file {"${plugin_basedir}/agent/puppetsyncrun.ddl":
    ensure => file,
    source => 'puppet:///modules/mco_plugins/mcollective-puppetsyncrun-agent/agent/puppetsyncrun.ddl',
    notify => Service['pe-mcollective'],
  }

  file {"${plugin_basedir}/agent/puppetsyncrun.rb":
    ensure => file,
    source => 'puppet:///modules/mco_plugins/mcollective-puppetsyncrun-agent/agent/puppetsyncrun.rb',
    notify => Service['pe-mcollective'],
  }
 
}
