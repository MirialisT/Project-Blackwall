extends Button


# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	var window_object: Window = preload("res://Scenes/terminal_instance.tscn").instantiate()
	get_tree().root.add_child(window_object)
