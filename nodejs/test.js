const os = require('os');
const fs = require('fs');
const http = require('http');

var totalMemory = os.totalmem();
var freeMemory = os.freemem();

console.log('Total Memory: ' + totalMemory);
console.log('Free Memory: ' + freeMemory);

const files = fs.readdirSync('./');

console.log(files);

fs.readdir('./', function(err, files) {
    if (err) console.log('Error: ', error)
    else console.log('Result: ', files)}
)

const server = http.createServer((req,res) => {
    if (req.url === '/') {
        res.write('Hello World');
        res.end();
    }

    if (req.url === '/api/courses') {
        res.write(JSON.stringify([1,2,3]));
        res.end();
    }
});


server.on('connection', (socket) => {
    console.log('New connection...');
});
server.listen(3000);
console.log('Listening on port 3000.');

