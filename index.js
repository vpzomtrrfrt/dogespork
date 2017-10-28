const parser = require('./language');

module.exports = function(content) {
	return parser.parse(content.toString());
};
