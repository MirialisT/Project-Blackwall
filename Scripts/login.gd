extends Button
signal LOGIN_PRESSED()

# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	LOGIN_PRESSED.emit()
