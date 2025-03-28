extends Button
signal MANUAL_BOOT(message: String, state: bool)

func _ready() -> void:
	self.grab_focus()
func _pressed() -> void:
	MANUAL_BOOT.emit("manual_boot", true)
