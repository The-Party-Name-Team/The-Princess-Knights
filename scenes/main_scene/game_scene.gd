extends Control


@export var HUD:CanvasLayer
@export var current_chapter:int = 0

@export var ChapterResources:Array[PackedScene]

var max_chapters:int
signal crossfade_finished

func _ready() -> void:
	max_chapters = len(ChapterResources)
	update_scene()

func update_scene():
	await get_tree().process_frame
	
	transition(3)
	await HUD.get_node("Transition").finished #fully opaque
	
	for child in get_children(): #clear scene
		child.queue_free()
	
	var current_scene := ChapterResources[current_chapter].instantiate()
	add_child(current_scene)
	current_scene.visible = true
	
	current_scene._forwards()
	current_scene.finished.connect(on_finish)

func on_finish():
	if current_chapter < max_chapters-1:
		current_chapter+=1
		update_scene()

func transition(seconds:float):
	HUD.get_node("Transition").inter_fade(seconds)

func crossfade():
	HUD.get_node("Transition").cross_fade()
	await HUD.get_node("Transition").finished
	crossfade_finished.emit()
