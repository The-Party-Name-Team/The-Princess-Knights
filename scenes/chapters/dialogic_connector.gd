extends Node

@export var timeline: DialogicTimeline
var allowed:= false

@export var background_ui: TextureRect
@export var background_texture: Texture

signal finished

func _ready() -> void:
	if timeline != null:
		allowed = true
		
func start():
	if allowed:
		if background_texture != null and background_ui != null:
			background_ui.texture = background_texture
		Dialogic.start(timeline.resource_path)
		await Dialogic.timeline_ended
		finished.emit()
