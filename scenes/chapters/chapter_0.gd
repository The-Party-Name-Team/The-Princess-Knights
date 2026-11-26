extends Control

@export var children_list: Array[Node]
var length:int

var current_step:int = 0

func _ready():
	length = len(children_list)
	for x in children_list:
		x.finished.connect(_onfinish)

func _forwards():
	if current_step < length:
		children_list[current_step].start()

func _onfinish():
	current_step +=1
	_forwards()


func _on_dialogic_connector_finished() -> void:
	_onfinish()


func _on_diary_finished() -> void:
	_onfinish()
