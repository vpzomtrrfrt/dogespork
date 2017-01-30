var fs = require('fs');
var parser = require('./language');

var fn = process.argv[2];
fs.readFile(fn, function(err, content) {
	console.log(parser.parse(content.toString()));
});
