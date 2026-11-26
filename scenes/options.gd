extends Panel

@export var settings_res: PlayerSettings

func _on_back_pressed() -> void:
	$Buttonclick2.play()
	await get_tree().create_timer(0.2).timeout
	
	if get_parent() != get_tree().root:
		queue_free()
		
	else :
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

func _on_back_mouse_entered() -> void:
	$Buttonhover2.play()
