var io = require('socket.io').listen(8888);

var tones = io.of('/tones').on('connection', function(socket) {

  socket.emit('greeting', { greeting: 'Hello client!'})
  socket.on('greeting', function(data) {
    console.log(data);
  });
});

var chat = io.of('/chat').on('connection', function(socket) {

  socket.on('message', function(data) {
    chat.emit('message', { message: data.message });
  });

  socket.on('disconnect', function() {
    chat.emit('message', { message: 'A user has disconnected!'});
  });

});

