extends Node

@export var timeline_name: String
var allowed:= false

signal finished

func _ready() -> void:
	if timeline_name != null:
		allowed = true
		
func start():
	print("fart")
	if allowed:
		Dialogic.start_timeline(timeline_name)
		finished.emit()
