extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anim_player = $AnimationPlayer
	
	anim_player.connect("animation_finished", _on_boot_seq1_end)
	anim_player.play("boot_seq1_text")
	pass # Replace with function body.

func _on_boot_seq1_end(_caller, boot_manual: bool = false):
	if boot_manual:
		print("Booting manually")
		$AnimationPlayer.stop(true)
		self.visible = false
		await(get_tree().create_timer(1.0).timeout)
		self.queue_free()
		print("Boot seq 2 start")
	else:
		print("Booting automatically")
	get_tree().change_scene_to_file("res://Scenes/boot_seq2.tscn")
