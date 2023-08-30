require 'socket'

# Define the server configuration
port = 8080

# Create a new server socket
server = TCPServer.new('localhost', port)

puts "Server started at http://localhost:#{port}/"

def handle_request(client, request)
  if request.start_with?("GET / HTTP/1.1")
    send_response(client, "index.html", "text/html")
  else
    send_not_found_response(client)
  end
end

def send_response(client, filename, content_type)
  response = "HTTP/1.1 200 OK\r\nContent-Type: #{content_type}\r\n\r\n"
  response_body = File.read(filename)
  client.puts response + response_body
end

def send_not_found_response(client)
  response = "HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\n\r\n"
  response_body = "<html><body><h1>404 Not Found</h1></body></html>"
  client.puts response + response_body
end

loop do
  client = server.accept
  request = client.gets

  if request
    puts "Received request: #{request}"
    handle_request(client, request)
  end

  client.close
end