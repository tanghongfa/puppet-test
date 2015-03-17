# /etc/puppetlabs/puppet/modules/mco_plugins/manifests/puppetsyncrun.pp
class mco_plugins::puppetsyncrun {
  Class['pe_mcollective::server::plugins'] -> Class[$title] ~> Service['pe-mcollective']
  include pe_mcollective
  $plugin_basedir = $pe_mcollective::server::plugins::plugin_basedir
  $mco_etc        = $pe_mcollective::params::mco_etc

  File {
    owner => $pe_mcollective::params::root_owner,
    group => $pe_mcollective::params::root_group,
    mode  => $pe_mcollective::params::root_mode,
  }

  file {"${plugin_basedir}/agent/puppetsyncrun.ddl":
    ensure => file,
    source => 'puppet:///modules/mco_plugins/mcollective-puppetsyncrun-agent/agent/puppetsyncrun.ddl',
  }

  file {"${plugin_basedir}/agent/puppetsyncrun.rb":
    ensure => file,
    source => 'puppet:///modules/mco_plugins/mcollective-puppetsyncrun-agent/agent/puppetsyncrun.rb',
  }
  
}
