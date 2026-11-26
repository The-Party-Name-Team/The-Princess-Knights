extends Control

@export var _sheets: Array[Control]
@export var _next_btn: Button

@export var next_scene: Control

var _current_sheet: int = 0
signal finished

func _ready() -> void:
	visible = true
	if len(_sheets)>0:
		for sheet in _sheets:
			for i in range (1, 3):
				sheet.get_node_or_null(str(i)).sheet_finished.connect(_on_page_finished)
			_next_btn.visible = false
	if not _next_btn == null:
		_next_btn.pressed.connect(_on_next)
			
func _on_page_finished(string_name):
	if int(string_name)%2 == 1:
		_sheets[_current_sheet].get_node_or_null("2").should_run = true
	else:
<<<<<<< Updated upstream
		if _current_sheet<len(_sheets)-1:
			_on_next()

func _on_next():
	_sheets[_current_sheet].visible = false
	_current_sheet+=1
	_sheets[_current_sheet].visible = true
	_sheets[_current_sheet].get_node_or_null("1").should_run = true
=======
		_next_btn.visible = true

func _on_next():
	if _current_sheet<len(_sheets)-1:
		_next_btn.visible = false
		_sheets[_current_sheet].visible = false
		_current_sheet+=1
		_sheets[_current_sheet].visible = true
		_sheets[_current_sheet].get_node_or_null("1").should_run = true
	else:
		_end_process()
>>>>>>> Stashed changes

func _end_process() -> void:
	finished.emit()
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
	if next_scene != null:
		next_scene.visible = true
