var io = require('socket.io').listen(8888);

io.sockets.on('connection', function (socket) {
  socket.emit('news', { news: 'Hello world!' });
  socket.on('message', function (data) {
    console.log(data);
  });
});
