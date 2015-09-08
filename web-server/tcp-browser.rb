require 'socket'
require 'json'

def get_request(path)
  "GET #{path} HTTP/1.0\n\n"
end

def post_request(path, content)
  length = content.length
  "POST #{path} HTTP/1.0\nContent-Length: #{length}\n\n#{content}"
end

# Sends a request (complete with headers and body) to server and returns the server's response (complete with headers and body) as a string.
def talk_to_server(host, port, request)
  socket = TCPSocket.open(host, port)
  socket.print(request)
  response = socket.read
  socket.close

  response
end

def run(path = '/index.html', host = 'localhost', port = 2000)
  loop do
    output = ""
    puts "What type of request would you like to make?"
    input = gets.chomp.upcase

    case input
    when "GET"
      request = get_request(path)
      output = talk_to_server(host, port, request)
    when "POST"
      puts "What is your name?"
      name = gets.chomp
      puts "What is your email?"
      email = gets.chomp
      viking_hash = {viking: {name: name, email: email}} # Store info in hash
      request = post_request('/thanks.html', viking_hash.to_json) # Create a post request string
      output = talk_to_server(host, port, request) # Create output based on server response
    when "QUIT" then break
    else
      output = "Invalid input."
    end

    puts output
  end
end

run
