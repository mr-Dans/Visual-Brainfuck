extends GridContainer

var cells = []
var cell = preload("res://Scenes/cell.tscn")

func _ready() -> void:
	addCells()

func addCells() -> void:
	for i in 256:
		cells.append(cell.instantiate())
		add_child(cells[i])
