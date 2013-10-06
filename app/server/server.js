var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')
  , path = require('path');

app.listen(8888);

function handler(req, res) {
  fs.readFile(path.join(__dirname, '..', 'assets', 'index.html'),
  function (err, data) {
    if (err) {
      res.writeHead(500);
      return res.end('Error loading index.html');
    }

    res.writeHead(200);
    res.end(data);
  });
}

io.sockets.on('connection', function (socket) {
  socket.emit('news', { news: 'Hello world!' });
  socket.on('message', function (data) {
    console.log(data);
  });
});
