extends TextureButton

func _on_pressed() -> void:
	$buttonclick.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	

func _on_mouse_entered() -> void:
	$buttonhover.play()
