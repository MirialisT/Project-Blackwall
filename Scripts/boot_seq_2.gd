extends Node

func _ready() -> void:
	#$TextureRect.size = get_viewport().get_window().size
	await(get_tree().create_timer(2.0).timeout)
	get_tree().change_scene_to_file("res://Scenes/login_screen.tscn")
