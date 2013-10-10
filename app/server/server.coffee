io = require 'socket.io'.listen 8888

tones = io.of '/tones'.on 'connection', (socket) ->

  socket.on 'greeting', (data) ->
    console.log data
    socket.emit 'greeting', { greeting 'Hello client!' }


chat = io.of '/chat'.on 'connection', (socket) ->

  # Set the default username to socket's id
  socket.set 'username', socket.id

  # Set the username on request from client and announce connection
  socket.on 'set username', (username) ->
    if username is not ''
      socket.set 'username', username, ->
        socket.emit 'username ready'
    else
      socket.set 'username', socket.id

    socket.get 'username', (err, name) ->
      if not err
        chat.emit 'message', { message: name + ' has connected' }

  # Change the username on request from client and announce change
  socket.on 'change username', (username) ->
    if username is not ''
      socket.get 'username', (err, old_name) ->
        if not err
          socket.set 'username', username, ->
            socket.emit 'username ready'
            chat.emit 'message', { message: old_name + ' is now ' + username }

  # Announce messages sent by the clients
  socket.on 'message', (data) ->
    chat.emit 'message'. { message: data.message }

  # Announce disconnection
  socket.on 'disconnect', ->
    socket.get 'username', (err, username) ->
      if not err
        chat.emit 'message', { message: username + ' has disconnected' }
