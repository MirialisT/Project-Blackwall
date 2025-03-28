extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Buttons/Login.LOGIN_PRESSED.connect(_on_login_pressed)
	$Info/EditBox/login.grab_focus()
	pass # Replace with function body.


func _on_login_pressed():
	var login: String = $Info/EditBox/login.text
	var password: String = $Info/EditBox/password.text
	print(login, password)
	if login == "kali" and password == "kali":
		get_tree().change_scene_to_file("res://Scenes/desktop.tscn")
