extends Control

@export var _container: Control
@export var _interval_in_seconds: float = 1
@export var _letters_per_seconds: float = 60

@export var _len_s: Array[int] = []

#should it run or not
@export var should_run:=false

#is the node ready
var is_ready:=false

var _ended := false

signal sheet_finished

var _allowed: bool = false
var _time_passed: float = 0

var _contained_labels: Array[Control]

var _current_iteration: int = 0

var _continue_disabled: bool = false

func _ready() -> void:
	if not _container is Control:
		_end_process()

func _prep(): #extended prep - after UIs have loaded
	var _i:int = 0
	while not is_ready:
		if _container.find_child(str(_i+1)):
			var cc: Control = _container.get_node(str(_i+1))
			cc.custom_minimum_size = cc.size #jitter prevention
			
			_contained_labels.append(cc)
			_len_s.append(len(cc.text)) #add lengths of strings
			
			cc.visible_characters = 0
			_i += 1
		else:
			is_ready = true
	#Ready!
	_allowed = true

func _process(delta: float) -> void:
	if _allowed:
		if should_run:
			_time_passed += delta
			if _time_passed >= _interval_in_seconds:
				if not _continue_disabled:
					_continue_disabled = true
					_continue()
	elif is_visible_in_tree() and not is_ready:
		is_ready = true
		_prep()

func _prep() -> void:
	# Wait 1 frame so Containers finish calculating Label widths after becoming visible
	await get_tree().process_frame
	
	var _i: int = 0
	while true:
		var cc: Control = _container.get_node_or_null(str(_i + 1))
		if cc:
			cc.custom_minimum_size = cc.size # Now captures the real visible size
			_contained_labels.append(cc)
			_len_s.append(len(cc.text))
			cc.visible_characters = 0
			_i += 1
		else:
			break
			
	_allowed = true

func _continue():
	if _current_iteration<len(_contained_labels):
		var cc: Control = _contained_labels[_current_iteration]
		_typewrite(cc)
	else:
		if not _ended:
			_end_process()
			_ended = true
		
func _typewrite(item: CanvasItem) -> void:
	var tween:= item.create_tween()
	var str_length = _len_s[_current_iteration]
	tween.tween_property(item, "visible_characters", str_length, str_length/_letters_per_seconds)
	
	await tween.finished
	_continue_disabled = false
	_time_passed=0
	_current_iteration+=1

func _end_process() -> void:
	if not _ended:
		process_mode = Node.PROCESS_MODE_DISABLED
		sheet_finished.emit(name)
		_ended = true
