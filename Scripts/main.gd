extends Control

var bf: BrainfuckInterpreter
var selectedCell: int
var delay: float

func _init() -> void:
	bf = BrainfuckInterpreter.new();
	selectedCell = 0;
	delay = 0.001;

func run_code() -> void:
	while bf.i != get_node("Code").text.length():
		bf.step(get_node("Code").text);
		if selectedCell != bf.ptr:
			get_node("Cells").get_child(selectedCell).deselect();
			selectedCell = bf.ptr;
		var cellValue = bf.stack[selectedCell];
		if bf.isPrint:
			get_node("Cells").get_child(selectedCell).print();
			get_node("Output").text = bf.result;
		else:
			get_node("Cells").get_child(selectedCell).select();
			get_node("Cells").get_child(selectedCell).text = str(cellValue);
		await get_tree().create_timer(delay).timeout;

func clear_code() -> void:
	bf.clear();
	get_node("Code").text = "";
	get_node("Output").text = "";
	for i in 256:
		get_node("Cells").get_child(i).deselect();
		if get_node("Cells").get_child(i).text != "0":
			get_node("Cells").get_child(i).text = "0";

func step_code() -> void:
	bf.step(get_node("Code").text);
	get_node("Cells").get_child(selectedCell).deselect();
	selectedCell = bf.ptr;
	var cellValue = bf.stack[selectedCell];
	if bf.isPrint:
		get_node("Output").text = bf.result;
	get_node("Cells").get_child(selectedCell).select();
	get_node("Cells").get_child(selectedCell).text = str(cellValue);

func _on_code_mouse_entered() -> void:
	get_node("Code").grab_focus();
	get_node("Code").anchor_top = 0.575;

func _on_code_mouse_exited() -> void:
	get_node("Code").release_focus();
	get_node("Code").anchor_top = 0.802;


func _on_delay_value_changed(value: float) -> void:
	delay = get_node("HBoxContainer/Delay").value/100;
	get_node("HBoxContainer/dPerc").text = str(delay) + " S";
