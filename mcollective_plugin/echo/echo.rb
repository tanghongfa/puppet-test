# $libdir/mcollective/agent/echo.rb
module MCollective
  module Agent
    class Echo<RPC::Agent
      action "run" do
        #reply[:msg] = request[:msg]
        reply[:statuscode] = run("/opt/puppet/bin/puppet agent -t", :stdout => :out, :stderr => :err)
        exitcode = reply[:statuscode]

        if exitcode == 0 || exitcode == 2 
          reply[:summary] = "Successfully run puppet agent -t command"
        else 
          reply.fail("Failed to run #{reply[:err]}")
        end
      end
    end
  end
end
