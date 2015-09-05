require 'socket'

def parse_request(req)
  h = {}
  puts req
  parts = req.split("\n\n")
  top = parts[0].split("\n")
  puts "Parts: #{parts.inspect}"
  puts "Top: #{top.inspect}"

  head = top[0].split(" ")
  h[:method] = head[0]
  h[:path] = head[1]
  h[:version] = head[2]

  h[:info] = top[1..-1]
  h[:body] = parts[1]

  h
end

def get_response(request)
  h = {version: request[:version]}
  path = request[:path].sub(/^\//, '')

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

def post_response(request)
  h = {version: request[:version]}
  path = request[:path].sub(/^\//, '')
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
  puts "Received request from client: #{request.inspect}"

  resp = ''
  
  case request[:method]
  when "GET"
    resp = get_response(request)
  when "POST"
    resp = post_response(request)
  else
  end

  client.puts resp
  client.puts "Closing the connection. Bye!"
  client.close                  # Disconnect from the client
end
