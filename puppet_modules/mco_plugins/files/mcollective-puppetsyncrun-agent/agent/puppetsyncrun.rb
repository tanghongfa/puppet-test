# $libdir/mcollective/agent/echo.rb
module MCollective
  module Agent
    class Puppetsyncrun<RPC::Agent
      action "run" do
        #reply[:msg] = request[:msg]
        reply[:statuscode] = run("/opt/puppet/bin/puppet agent -t", :stdout => :out, :stderr => :err)
        exitcode = reply[:statuscode]
        reply.fail("Failed to run #{reply[:err]}")
      end
    end
  end
end
