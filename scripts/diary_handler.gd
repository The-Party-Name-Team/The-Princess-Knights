extends Control

@export var _container: Control
@export var _interval_in_seconds: float = 1
@export var _letters_per_seconds: float = 60

@export var _len_s: Array[int] = []

var _allowed: bool = false
var _time_passed: float = 0

var _contained_labels: Array[Control]

var _current_iteration: int = 0

var _continue_disabled: bool = false

func _ready() -> void:
	if not _container is Control:
		_end_process()

func _prep(): #extended prep - after UIs have loaded
	var isReady:bool = false
	var _i:int = 0
	while not isReady:
		if _container.find_child(str(_i+1)):
			var cc: Control = _container.get_node(str(_i+1))
			cc.custom_minimum_size = cc.size #jitter prevention
			print(cc.size, cc.custom_minimum_size)
			
			_contained_labels.append(cc)
			_len_s.append(len(cc.text)) #add lengths of strings
			
			cc.visible_characters = 0
			_i+=1
		else:
			isReady = true
	#Ready!
	_allowed = true

func _process(delta: float) -> void:
	if _allowed:
		#makeshift loop
		_time_passed += delta
		if _time_passed>=_interval_in_seconds:
			if not _continue_disabled:
				_continue_disabled = true
				_continue()
	else:
		_prep()

func _continue():
	if _current_iteration<len(_contained_labels):
		var cc: Control = _contained_labels[_current_iteration]
		_typewrite(cc)
	else:
		print("hi")
		_end_process()
		
func _typewrite(item: CanvasItem) -> void:
	var tween:= item.create_tween()
	var str_length = _len_s[_current_iteration]
	tween.tween_property(item, "visible_characters", str_length, str_length/_letters_per_seconds)
	await tween.finished
	_continue_disabled = false
	_time_passed=0
	_current_iteration+=1

func _end_process() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
