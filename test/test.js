const fs = require('fs');
const dogespork = require('..');
const test = require('tape');
const glob = require('glob');
const path = require('path');
const beautify = require('js-beautify');

const srcDir = path.join(__dirname, 'spec');

const files = glob.sync('**/source.dsjs', {
	cwd: srcDir
});

files.sort();
files.forEach(function(filename) {
	const filepath = path.join(srcDir, filename);
	if(!fs.statSync(filepath).isFile()) return;

	const dirname = path.dirname(filepath);

	test(filepath, function(t) {
		t.plan(1);

		const description = dirname;

		const source = fs.readFileSync(filepath, 'utf8');

		const expected = fs.readFileSync(path.join(dirname, 'expect.js'), 'utf8').trim();

		const actual = beautify(dogespork(source));

		t.equal(actual, expected, description);
	});
});

// test syntax errors
test("syntax error reporting", function(t) {
	t.plan(1);

	let error;
	t.throws(() => dogespork("very walrus is 5"), /"w" found/, "variables can't start with w");
});
