# $libdir/mcollective/agent/echo.rb
module MCollective
  module Agent
    class Echo<RPC::Agent
      action "echo" do
        #reply[:msg] = request[:msg]
        reply[:statuscode] = run("/opt/puppet/bin/puppet agent -t", :stdout => :out, :stderr => :err)
        exitcode = reply[:statuscode]
        reply.fail("Failed to run #{reply[:err]}")
      end
    end
  end
end
