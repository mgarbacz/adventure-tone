io = require('socket.io').listen 8888

# Store history of element ids clicked in order clicked on
elements = []

tones = io.of('/tones').on 'connection', (socket) ->

  # TODO - refactor into useful connection event
  socket.on 'greeting', (data) ->
    console.log data
    socket.emit 'greeting', { greeting: 'Hello client!' }

  # Get new client up to date with current grid state
  socket.emit 'grid status', { elements: elements }

  # Take grid click events and broadcast to all other clients
  socket.on 'grid click', (data) ->
    console.log data
    # Store element clicked for syncing new clients
    elements.push data.element
    socket.broadcast.emit 'grid click', { element: data.element }


chat = io.of('/chat').on 'connection', (socket) ->

  # Set the username on request from client and announce connection
  socket.on 'set username', (username) ->
    if username isnt ''
      # User has chosen username
      socket.set 'username', username, ->
        socket.emit 'username ready'
    else
      # User has not chosen username
      socket.set 'username', socket.id

    socket.get 'username', (err, name) ->
      if not err
        chat.emit 'message', { message: name + ' has connected' }

  # Change the username on request from client and announce change
  socket.on 'change username', (username) ->
    if username isnt ''
      socket.get 'username', (err, old_name) ->
        if not err
          socket.set 'username', username, ->
            socket.emit 'username ready'
            chat.emit 'message', { message: old_name + ' is now ' + username }

  # Announce messages sent by the clients
  socket.on 'message', (data) ->
    chat.emit 'message', { message: data.message }

  # Announce disconnection
  socket.on 'disconnect', ->
    socket.get 'username', (err, username) ->
      if not err
        chat.emit 'message', { message: username + ' has disconnected' }
