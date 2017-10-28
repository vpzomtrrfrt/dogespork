var fs = require('fs');
const dogespork = require('.');

var fn = process.argv[2];
fs.readFile(fn, function(err, content) {
	console.log(dogespork(content));
});
