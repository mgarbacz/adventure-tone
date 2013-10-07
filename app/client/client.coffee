socket = io.connect '//localhost:8888/tones'

socket.on 'connect', ->
  socket.on 'greeting', (data) ->
    console.log data
  socket.emit 'greeting', { greeting: 'Hi server!' }
