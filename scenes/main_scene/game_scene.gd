extends Control

var current_scene: ChapterScript

@export var HUD:CanvasLayer
@export var current_chapter:int = 0

var max_children

func _ready() -> void:
	update_scene()
	current_scene = get_child(0)

func update_scene():
	await get_tree().process_frame
	max_children = self.get_child_count()
	
	transition()
	await HUD.get_node("Transition").finished
	
	current_scene.visible = false
	current_scene = get_child(current_chapter)
	current_scene.visible = true
	
	current_scene._forwards()
	current_scene.finished.connect(on_finish)

func on_finish():
	if current_chapter < max_children-1:
		current_chapter+=1
		update_scene()

func transition():
	HUD.get_node("Transition").inter_fade()

func crossfade():
	HUD.get_node("Transition").cross_fade()
