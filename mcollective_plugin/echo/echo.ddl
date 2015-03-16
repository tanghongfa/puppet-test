# $libdir/mcollective/agent/echo.ddl
metadata :name        => 'echo',
         :description => 'Echo service for MCollective',
         :author      => 'R.I.Pienaar',
         :license     => 'GPLv2',
         :version     => '1.1',
         :url         => 'https://docs.puppetlabs.com/mcollective/simplerpc/agents.html',
         :timeout     => 60

action 'echo', :description => 'Echos back any message it receives' do
    display :always

    input :msg,
          :prompt      => 'Message',
          :description => 'Your message',
          :type        => :string,
          :validation  => '.*',
          :optional    => false,
          :maxlength   => 1024

    output :msg,
        :description => 'Your message',
        :display_as  => 'Message',
        :default     => ''
end