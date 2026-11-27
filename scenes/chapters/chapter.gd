extends Control
class_name ChapterScript

@export var children_list: Array[Node]
var length:int

var current_step:int = 0

signal finished

func _ready():
	length = len(children_list)
	for x in children_list:
		x.finished.connect(_onfinish)

func _forwards():
	if current_step < length:
		if current_step != 0:
			get_parent().crossfade()
			await get_parent().crossfade_finished
		children_list[current_step-1].end_process()
		children_list[current_step].start()
	else:
		finished.emit()

func _onfinish():
	current_step +=1
	_forwards()
