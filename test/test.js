const fs = require('fs');
const dogespork = require('..');
const test = require('tape');
const glob = require('glob');
const path = require('path');

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

		const actual = dogespork(source);

		t.equal(actual, expected, description);
	});
});
