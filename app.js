const http = require('http');
const os = require('os');

console.log("Kubia/NodeJS server starting");

var handler = function(request, response) {
  console.log("Received request from " + request.connection.remoteAddress);
  response.writeHead(200);
  response.end("You've hit " + os.hostname() + "\n");
}

var server = http.createServer(handler);
server.listen(8080);