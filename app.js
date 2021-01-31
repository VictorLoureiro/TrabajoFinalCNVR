const http = require('http');
const process = require('process');

const hostIP = process.argv[2];
const hostNAME = process.argv[3];
const port = 80;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hola! Estás en el Servidor ${hostNAME}');
});

server.listen(port, hostIP, () => {
  console.log(`El servidor se está ejecutando en http://${hostIP}:${port}/`);
});
