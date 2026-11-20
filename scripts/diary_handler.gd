extends Control

@export var _container: Control
@export var _interval_in_seconds: float = 1
@export var _fade_duration_in_seconds: float = 1

var _allowed: bool = false
var _time_passed: float = 0

var _contained_labels: Array[Control]

var _current_iteration: int = 0

var _continue_disabled: bool = false

func _ready() -> void:
	var isReady:bool = false
	if _container is Control:
		#loop for making everything invisible first
		var _i:int = 0
		while not isReady:
			if _container.find_child(str(_i+1)):
				var cc: Control = _container.get_node(str(_i+1))
				_contained_labels.append(cc)
				cc.modulate.a = 0
				_i+=1
			else:
				isReady = true
		#Ready!
		_allowed = true
		return
	_end_process()
	
func _process(delta: float) -> void:
	if _allowed:
		#makeshift loop
		_time_passed += delta
		if _time_passed>=_interval_in_seconds:
			if not _continue_disabled:
				_continue_disabled = true
				_continue()

func _continue():
	if _current_iteration<len(_contained_labels):
		var cc: Control = _contained_labels[_current_iteration]
		_fade_in(cc)
	else:
		print("hi")
		_end_process()
		print("hoy")
		
func _fade_in(item: CanvasItem) -> void:
	var tween:= item.create_tween()
	tween.tween_property(item, "modulate:a", 1.0, _fade_duration_in_seconds)
	await tween.finished
	_continue_disabled = false
	_time_passed=0
	_current_iteration+=1
		
func _end_process() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
