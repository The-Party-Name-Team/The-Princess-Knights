extends Node2D

func _on_start_pressed() -> void:
	$buttonclick.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/main_scene/game.tscn")
	
func _on_leave_pressed() -> void:
	$buttonclick.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
	
func _on_config_pressed() -> void:
	$buttonclick.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/options.tscn")
	
func _on_mapbut_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map.tscn")
	$buttonclick.play()

func _on_start_mouse_entered() -> void:
	$buttonhover.play()
	
func _on_config_mouse_entered() -> void:
	$buttonhover.play()
	
func _on_leave_mouse_entered() -> void:
	$buttonhover.play()
