# $libdir/mcollective/agent/echo.rb
module MCollective
  module Agent
    class Echo<RPC::Agent
      action "echo" do
        #reply[:msg] = request[:msg]
        reply[:statuscode] = run("ls -al", :stdout => :out, :stderr => :err)
      end
    end
  end
end
