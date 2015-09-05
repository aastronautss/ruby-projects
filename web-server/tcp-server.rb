require 'socket'

def parse_request(req)
  h = {}
  lines = req.split("\n")
  head = lines[0].split(" ")
  h[:method] = head[0]
  h[:path] = head[1]
  h[:version] = head[2]

  h
end

def response(request)
  h = {version: request[:version]}
  path = request[:path][1..-1]
  puts path

  if File.exist?(path)
    h[:status] = 200
    h[:status_message] = "OK"
    file = File.open(path, "r")
    body = file.read
    file.close
    h[:date] = File.mtime(path)
    h[:length] = body.length
    h[:body] = body

  else
    h[:status] = 404
    h[:status_message] = "Not Found"
  end

  format_response(h)
end

def format_response(h)
  s = "#{h[:version]} #{h[:status]} #{h[:status_message]}\n"
  if h[:status] == 200
    s << "Date: #{h[:date]}\n"
    s << "Content-Length: #{h[:length]}\n\n"
    s << h[:body]
  end

  s
end


server = TCPServer.open(2000)

loop do
  client = server.accept        # Wait for a client to connect
  request = parse_request(client.gets)
                                # Get request from client and send it to parse
  case request[:method]
  when "GET"
    resp = response(request)
    client.puts resp
  else
  end
  client.puts "Closing the connection. Bye!"
  client.close                  # Disconnect from the client
end
