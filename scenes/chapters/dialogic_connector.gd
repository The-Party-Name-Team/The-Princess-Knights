extends Node

@export var timeline_name: String
var allowed:= false

signal finished

func _ready() -> void:
	if timeline_name != null:
		allowed = true
		
func start():
	if allowed:
		Dialogic.start(timeline_name)
		await Dialogic.timeline_ended
		finished.emit()
