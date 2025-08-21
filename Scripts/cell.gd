class_name Cell extends Label

var styleBox: StyleBoxFlat = StyleBoxFlat.new()

func _ready() -> void:
	styleBox.bg_color = Color('#000000');
	styleBox.border_color = Color('#000000');
	styleBox.set_border_width_all(5);

func select() -> void:
	styleBox.border_color = Color('#FFFFFF');
	add_theme_stylebox_override("normal", styleBox);

func deselect() -> void:
	styleBox.border_color = Color('#000000');
	add_theme_stylebox_override("normal", styleBox);
	
func print() -> void:
	styleBox.border_color = Color('#FF0000');
	add_theme_stylebox_override("normal", styleBox);
