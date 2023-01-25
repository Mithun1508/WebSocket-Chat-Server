require 'em-websocket'
require 'json'
require_relative 'json-handler'

ChatSocket = Struct.new(:socket) do
  Channel = EM::Channel.new
  Handler = JH.new

  def initialize(socket)
    self.socket = socket
    @username = ''

    socket.onclose { on_close }
    socket.onmessage { |message| on_message(message) }
    socket.onopen { on_open }
  end

  def on_close
    Handler.remove_user(@username)
    puts 'Connection closed'
  end

  def on_message(json)
    message = Handler.handle(json, socket)
    response = JSON.generate(message)
    type = message[:type]

    if type == :chat
      Channel.push response
    else
      @username = message[:username] if type == :logged_in

      socket.send(response)
    end
  end

  def on_open
    Channel.subscribe { |message| socket.send(message) }
  end
end
