require 'socket'

# A basic viking-themed server that runs in the command line, taking basic 
# GET and POST requests.
class VikingServer
  # Initializes server with a given port (default 2000)
  def initialize(port = 2000)
    @port = port
  end

  def run
    server = TCPServer.open(@port)

    loop do
      client = server.accept        # Wait for a client to connect
      request = parse_request(client)
      puts "REQUEST: #{request.inspect}"

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
  end

  # Takes an HTTP request from a client, and breaks it (taken as a string) 
  # down into a hash, with each value providing all the needed information 
  # for a given request.
  def parse_request(client)
    r = {}
    head = read_header(client) # Get header from client

    # The initial request line is specal so we'll deal with it first.
    initial_line = head.shift.split(" ")
    r[:method] = initial_line[0]
    r[:path] = initial_line[1]
    r[:version] = initial_line[2]

    # Take the additioanl lines from the header and add them as key/value 
    # pairs.
    r = hashify_header(head, r)

    # Add body to response if there is one.
    content_length = r["Content-Length"].to_i
    puts "CONTENT LENGTH: #{content_length}"
    r[:body] = read_body(client, content_length) unless content_length.nil? || content_length == 0

    r
  end

  # Takes all of the lines from a client's request until a double newline is 
  # given, indicating the beginning of the body. The result is an array 
  # containing each of the lines of the HTTP request's header. This is a 
  # helper metho
  def read_header(client)
    line = client.gets
    header = ""
    until line == "\n"
      header << line
      line = client.gets
    end

    header.split("\n")
  end

  # Takes lines from header and adds them to a given hash as key/value pairs.
  def hashify_header(head, hash = {})
    head.each do |line|
      pair = line.split(": ")
      key = pair[0]
      value = pair[1]
      hash[key] = value
    end

    hash
  end

  def read_body(client, length)
    s = ""
    length.times do 
      s << client.readchar
    end

    s
  end

  # Provides a resonse to a GET request. Takes the variable 'request' in the form of a hash.
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

  # Provides a response to a POST request. Takes the variable 'request' in 
  # the form of a hash.
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
end

my_server = VikingServer.new
my_server.run
