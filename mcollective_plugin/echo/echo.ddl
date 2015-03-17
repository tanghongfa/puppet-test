# $libdir/mcollective/agent/echo.ddl
metadata :name        => 'echo',
         :description => 'Plugin to Run puppet with command "puppet agent -t',
         :author      => 'HongFa Tang',
         :license     => 'GPLv2',
         :version     => '0.1',
         :url         => 'https://docs.puppetlabs.com/mcollective/simplerpc/agents.html',
         :timeout     => 60

action 'echo', :description => 'Run "puppet agent -t" command and return back the output"' do
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