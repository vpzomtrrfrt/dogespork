{
	function checkVar(x) {
		if(x == "console.loge") return "console.log";
		if(x == "windoge") return "window";
		if(x == "dogeument") return "document";
		return x;
	}
}

start = statements: (statement:(statement) [ \t]* ("shh" [^\n]*) ? ("\n" * / "   " * / !.) { return statement; }) * { return statements.join(""); }

statement = ws statement:(
	"rly" condition:expression "\n" body:start ws "wow" { return "if("+condition+"){"+body+"}"; } /
	"but rly" condition:expression "\n" body:start ws "wow" { return "else if("+condition+"){"+body+"}"; } /
	"but" wsn body:start ws "wow" { return "else{"+body+"}"; } /
	x: (
		"shh" [^\n]* { return ""; } /
		"very" ws name:identifier ws "is" ws value:expression { return "var "+name+"="+value; } / 
		name:ref ws "is" ws value:expression { return name+"="+value; } /
		expression
	) { return x+";";}
) { return statement; }

expression = (
	ws x:(
		"'" chars: char* "'" { return "'" + chars.join("") + "'"; } /
		digits:digit+ { return parseInt(digits.join(""),8).toString(10); } /
		"plz" ws ref:ref ws "with" ws params:params { return ref+"("+params+")"; } /
		ref1:ref ws "dose" ws ref2:identifier ws "with" ws params:params { return checkVar(ref1+"."+ref2)+"("+params+")"; } /
		"much" ws params:(key:identifier ws { return key; }) * "\n" ws body:start ws "wow" { return "function("+params.join(",")+"){"+body+"}" } /
		ref /
		"(" x:expression ")" { return "("+x+")";}
	) ops:(operation1 *) ws { return x+ops.join(""); }
)

params = params:(expression:expression ws ","? { return expression; }) * { return params.join(",");}

operation1 = (
	ws operator:(
		"is not" { return "!=="; } /
		"is" { return "==="; } /
		"and" { return "&&"; } /
		"plus" { return "+"; }
	) exp:expression {return operator + exp;}
)

char = (
	[^'\\] /
	"\\" char: (
		"'" /
		"\\" /
		"n" /
		"t" /
		"r" /
		"f" /
		"b" /
		("u" digits: digit {6}) { return "u"+parseInt(digits.join(""), 8).toString(16); }
	) {return "\"" + char}
)

wsc = [ \t]

ws = wsc *

wsn = (wsc / "\n") *

identifier = first: varstart remain: varcont * { return first+remain.join(""); }

varstart = [A-Za-vx-z_$Ɖ]

varcont = (
	varstart /
	[0-9]
)

digit = [0-7]

ref = x:(
	ref:identifier mods:right_modifier * { return ref+mods.join(""); }
) { return checkVar(x); }

right_modifier = (
	"++" /
	"--" /
	"." ref:identifier { return "."+ref; } /
	"[" ref:expression "]" { return "["+ref+"]"; }
)
