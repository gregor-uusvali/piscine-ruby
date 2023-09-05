require 'webrick'
require 'erb'

# Data is a class for sending Ascii art and errors to HTML templates
class MyData
  attr_accessor :ascii_art, :error

  def initialize(ascii_art, error)
    @ascii_art = ascii_art
    @error = error
  end
end

# Home is the home page handler
class HomeHandler < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    if request.path != '/'
      response.set_redirect(WEBrick::HTTPStatus::MovedPermanently, '/')
    else
      render_template(response, 'index.html', MyData.new(nil, nil))
    end
  end
end

# Define a new route handler for /hexgame.html
class HexGameHandler < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    render_template(response, 'hexgame.html', MyData.new(nil, nil))
  end
end

# AsciiArt is the handler for /ascii-art
class AsciiArtHandler < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    # Handle GET requests, e.g., show a form to input text
    render_template(response, 'ascii.html', MyData.new(nil, nil))
  end

  def do_POST(request, response)
    # Handle POST requests, e.g., process form data and generate ASCII art
    user_input = request.query['user-input']
    if user_input
      # Example: Generating ASCII art from user_input
      int_array = user_input.gsub('\n', "\n").bytes.map(&:to_i)
      ascii_art = generate_ascii_from_user_input("", int_array)
      render_template(response, 'ascii.html', MyData.new(ascii_art, nil))
    else
      response.status = 400
      response.body = 'Bad Request: Missing user input'
    end
  end

  # Add your ASCII art generation logic here
  def generate_ascii_from_user_input(res, arr)
    new_line = false
    new_line_idx = 0
    for j in 0..7 do
        if (arr[0] == 10 || arr.length == 0) ||( arr[0] == 13 && arr[1] == 10)
            res = res + "\n"
            new_line = true
            break
        end
        arr.each_with_index do |i, idx|
            index = 1 + (i-32) * 1 + (i-32) * 8
            if index == -170
                new_line = true
                new_line_idx = idx
                break
            end
            File.open("standard.txt", "r") do |file|
                res = res + file.readlines()[index+j].chop
            end
        end
        res = res + "\n"
    end
    if new_line && arr.length != 0
        after_nl = generate_ascii_from_user_input("", arr[new_line_idx+1..-1])
        res = res + after_nl
    end
    return res
  end
end

# render_template renders templates using ERB (Embedded Ruby)
def render_template(response, template_name, data)
  begin
    template = ERB.new(File.read("./templates/#{template_name}"))
    @data = data
    response.body = template.result(binding)
    response['Content-Type'] = 'text/html'
  rescue StandardError => e
    puts "Error rendering template: #{e}"
    response.status = 500
    response.body = 'Internal Server Error'
  end
end

# Create a WEBrick HTTP server
server = WEBrick::HTTPServer.new(Port: 8080)

# Define handlers for the routes
server.mount('/', HomeHandler)
server.mount('/hexgame', HexGameHandler)
server.mount('/ascii', AsciiArtHandler)
server.mount('/generate-ascii', AsciiArtHandler)

# Start the server
trap('INT') { server.shutdown }
server.start