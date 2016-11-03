var http = require('http');
var express = require('express');

var data = "";

// Express cconfiguration
var app = express();
app.disable('x-powered-by'); // hide express to reduce security risk

// Must respond HTTP 200 to /health for openshift
app.get('/health', function(request, response) {
    response.sendStatus(200);
});

// Homepage
app.get('/', function(request, response) {
    response.setHeader('content-type', 'text/plain');
    response.end(data);
});

// Start listening
var server = http.createServer(app);
server.on('connection', function(socket) {
    socket.on('data', function(chunk) {
        data = data + chunk.toString();
    });
});
server.listen(process.env.NODE_PORT || 8888, process.env.NODE_IP || '0.0.0.0', function () {
    console.log(`Application worker ${process.pid} started...`);
});
