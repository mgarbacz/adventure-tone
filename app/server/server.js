var io = require('socket.io').listen(8888);

io.sockets.on('connection', function (socket) {

  socket.on('message', function (data) {
    console.log(data);
    io.sockets.emit('message', { message: data.message });
  });

  socket.on('disconnect', function () {
    io.sockets.emit('message', { message: 'A user has disconnected!'});
  });

});

