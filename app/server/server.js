var io = require('socket.io').listen(8888);

var tones = io.of('/tones').on('connection', function(socket) {

  socket.on('greeting', function(data) {
    console.log(data);
    socket.emit('greeting', { greeting: 'Hello client!'})
  });

});

var chat = io.of('/chat').on('connection', function(socket) {

  // Set the default usename to socket's id
  socket.set('username', socket.id);

  // Set the username on request from client and announce connection
  socket.on('set username', function(username) {
    if (username != '') {
      socket.set('username', username, function() {
        socket.emit('username ready');
      });
    }
    socket.get('username', function(err, name) {
      if (!err)
        chat.emit('message', { message: name + ' has connected'});
    });
  });

  // Change the username on request from client and announce change
  socket.on('change username', function(username) {
    if (username != '') {
      socket.get('username', function(err, old_name) {
        socket.set('username', username, function() {
          socket.emit('username ready');
          chat.emit('message', { message: old_name + ' is now ' + username});
        });
      });
    }
  });

  // Announce messages sent by the clients
  socket.on('message', function(data) {
    chat.emit('message', { message: data.message });
  });

  // Announce disconnection
  socket.on('disconnect', function() {
    socket.get('username', function(err, username) {
      if (!err)
        chat.emit('message', { message: username + ' has disconnected'});
    });
  });

});

