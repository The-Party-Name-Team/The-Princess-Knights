extends Control

var random_events = [
	"res://scenes/event_1.tscn",
	"res://scenes/event_2.tscn",
	"res://scenes/event_3.tscn"
]

#neows
func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

#random events
func _on_level_2_pressed() -> void:
	var chosen_event: String = random_events.pick_random()
	get_tree().change_scene_to_file(chosen_event)
	
#rest
func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
