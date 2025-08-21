class_name BrainfuckInterpreter
extends Node

''' Brainfuck Interpreter
Description:
	Brainfuck is a minimalistic imperative programming language, designed by Urban Müller around 1993.
	The source code for a brainfuck program consists of a single file of ASCII text, whose filename
	should ideally end with ".b".Each character in the file is either a command, or not. Characters
	that are not commands are ignored.

Commands:
	+ (will add 1 to the current cell value)
	- (will subtract 1 to the current cell value)
	> (will move 1 position to the next cell on the right)
	< (will move 1 position to the next cell on the left)
	[ (will open a loop)
	] (will close a loop if the current cell value is 0)
	, (will read one keyboard input and store it in the current cell)
	. (will print, in ASCII, the value on the current cell)
'''

static var stack: Array[int]
static var ptr: int
static var i: int
static var loopEntry: Array[int]
static var result: String
static var isPrint: bool

func _init() -> void:
	stack.resize(256);
	stack.fill(0);
	ptr = 0;
	i = 0;
	loopEntry.resize(1);
	loopEntry.fill(0);
	result = "";
	isPrint = false;

func passCommand(cmd: String) -> void:
	if isPrint: isPrint = false;
	match cmd:
		'+':
			stack[ptr] = stack[ptr] + 1 if stack[ptr] < 255 else 0;
		'-':
			stack[ptr] = stack[ptr] - 1 if stack[ptr] > 0 else 255;
		'>':
			ptr = ptr + 1 if ptr < 255 else 0;
		'<':
			ptr = ptr - 1 if ptr > 0 else 255;
		'[':
			if loopEntry[-1] != i:
				loopEntry.append(i);
		']':
			if stack[ptr] == 0:
				loopEntry.resize(loopEntry.size()-1);
			else:
				i = loopEntry[-1];
		'.':
			result += String.chr(stack[ptr]);
			isPrint = true;

func run(code: String) -> String:
	while i < code.length():
		passCommand(code[i]);
		i+=1;
	return result;

func step(code: String) -> void:
	passCommand(code[i]);
	i+=1;

func clear() -> void:
	stack.fill(0);
	ptr = 0;
	i = 0;
	loopEntry.resize(1);
	loopEntry.fill(0);
	result = "";
