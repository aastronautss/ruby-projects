require 'socket'

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

while line = s.gets # Read lines from the socket
  puts line.chomp   # Print with platform lien terminator
end

s.close