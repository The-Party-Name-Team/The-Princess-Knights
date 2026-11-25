extends Node2D

@onready var mainmenubuttons: Control = $mainmenubuttons
@onready var options: Panel = $CanvasLayer/options

func _ready() :
	mainmenubuttons.visible = true
	options.visible = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_leave_pressed() -> void:
	get_tree().quit()

func _on_config_pressed() -> void:
	mainmenubuttons.visible = false
	options.visible = true 
	
func _on_mapbut_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
