io = require('socket.io').listen process.env.PORT || 8888

# Store history of clicks in order of elements clicked on
clicks = []

tones = io.of('/tones').on 'connection', (socket) ->

  # TODO - refactor into useful connection event
  socket.on 'greeting', (data) ->
    console.log data
    socket.emit 'greeting', { greeting: 'Hello client!' }

  # Get new client up to date with current grid state
  socket.emit 'grid status', { clicks: clicks }

  # Take grid click events and broadcast to all other clients
  socket.on 'grid click', (data) ->
    console.log data
    # Store element clicked for syncing new clients
    clicks.push data
    socket.broadcast.emit 'grid click',
      # TODO - fix sender to identify sender
      { element: data.element, sender: data.sender }
