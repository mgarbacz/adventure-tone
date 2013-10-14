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
