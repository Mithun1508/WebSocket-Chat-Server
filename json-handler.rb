require 'em-websocket'
require 'json'

class JsonHandler
  Users = [].freeze

  def handle(json, socket)
    message = JSON.parse(json)
    type = message['type']

    case type
    when 'login' then handle_login(message, socket)
    when 'logout' then handle_logout(message)
    when 'chat' then handle_chat(message)
    else handle_unknown(message)
    end
  end

  def remove_user(username)
    Users.delete(username) if Users.include?(username)
  end

  private

  def handle_chat(message)
    {
      type: :chat,
      username: message['username'],
      value: message['value']
    }
  end

  def create_channel(username, _socket)
    exists = Users.include?(username)

    Users.push(username) unless exists

    exists
  end

  def handle_login(message, socket)
    # login
    username = message['username']
    exists = create_channel(username, socket)
    type = if exists
             :login_failure
           else
             :logged_in
           end

    {
      type: type,
      username: username
    }
  end

  def handle_logout(message)
    # logout
    username = message['username']

    remove_user(username)

    {
      type: :logged_out,
      username: username,
      value: true
    }
  end

  def handle_unknown(message)
    username = message['username']

    {
      type: :error,
      username: username,
      value: 'Unknown message type'
    }
  end
end

JH = JsonHandler
