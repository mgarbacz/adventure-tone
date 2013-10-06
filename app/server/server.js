var io = require('socket.io').listen(8888);

var chat = io.of('/chat').on('connection', function(socket) {

  socket.on('message', function() {
    chat.emit('message', { message: data.message });
  });

  socket.on('disconnect', function() {
    chat.emit('message', { message: 'A user has disconnected!'});
  });

});

