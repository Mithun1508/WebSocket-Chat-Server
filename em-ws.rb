require 'em-websocket'
require_relative 'chat-socket'

EventMachine.run do
  host = '0.0.0.0'
  port = 3000

  EventMachine::WebSocket.start(host: host, port: port) do |ws|
    ChatSocket.new(ws)
  end

  puts "Start server at #{host}:#{port}"
end
