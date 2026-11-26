extends Control

@export var _sheets: Array[Control]
@export var _next_btn: Button

@export var _change_interval: float = 2

var _current_sheet: int = 0
signal diary_finished

func _ready() -> void:
	if len(_sheets)>0:
		for sheet in _sheets:
			for i in range (1, 3):
				sheet.get_node_or_null(str(i)).sheet_finished.connect(_on_page_finished)
	if not _next_btn == null:
		_next_btn.pressed.connect(_on_next)
			
func _on_page_finished(string_name):
	if int(string_name)%2 == 1:
		_sheets[_current_sheet].get_node_or_null("2").should_run = true
	else:
		if _current_sheet<len(_sheets)-1:
			_on_next()

func _on_next():
	_sheets[_current_sheet].visible = false
	_current_sheet+=1
	_sheets[_current_sheet].visible = true
	_sheets[_current_sheet].get_node_or_null("1").should_run = true

func _end_process() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	diary_finished.emit()
