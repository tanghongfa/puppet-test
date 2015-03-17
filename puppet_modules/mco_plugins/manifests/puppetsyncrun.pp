# /etc/puppetlabs/puppet/modules/mco_plugins/manifests/puppetsyncrun.pp
class mco_plugins::puppetsyncrun {
  #Class['pe_mcollective::server::plugins'] -> Class[$title] ~> Service['pe-mcollective']
  #include pe_mcollective
  #$plugin_basedir = $pe_mcollective::server::plugins::plugin_basedir
  #$mco_etc        = $pe_mcollective::params::mco_etc

  #File {
  #  owner => $pe_mcollective::params::root_owner,
  #  group => $pe_mcollective::params::root_group,
  #  mode  => $pe_mcollective::params::root_mode,
  #}

  #Class['puppet_enterprise::mcollective::server::plugins'] -> Class[$title] ~> Service['pe-mcollective']
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
