extends Node2D

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_leave_pressed() -> void:
	get_tree().quit()

func _on_config_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/configuration.tscn")

func _on_mapbut_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map.tscn")
