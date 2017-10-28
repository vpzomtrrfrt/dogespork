const parser = require('./language');

module.exports = function(content) {
	content = content.toString();
	try {
		return parser.parse(content);
	} catch(e) {
		e.message += "\n\t at "+e.location.start.line+":"+e.location.start.column+"-"+e.location.end.line+":"+e.location.end.column;
		throw e;
	}
};
