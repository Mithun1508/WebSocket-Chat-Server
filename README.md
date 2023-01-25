WebSocket Chat Server with Ruby 

# Dependencies
The only dependency is the EM-WebSocket library. To install it, just run:

"gem install em-websocket"  

# Running the Server

To run the server:
"ruby em-ws.rb"

# Message Format
The format for a message, both to and from the client, is:

{

    type: string;
    
    username: string;
    
    value?: any;
    
}
All messages require a type and username, but only some messages will provide or require a value.

To see the types of messages the client can send, please see Accepted Message Types. For the types of messages the server will send, please see Response Types.

1) Accepted Messages and its Types
 
 1)Type- Purpose

2) login- Let's a user register their username, must be unique

3) logout- Unregister the username

4) chat	- Send a chat message


Responses and its Types

Type	Purpose

login_failure	Username from a login is taken


logged_in	Username successfully registered

chat	A chat message was sent

error	An unknown message type was sent

All users receive the chat messages, but only the sending user will receive the other three message types.
