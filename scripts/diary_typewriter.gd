extends Control

@export var _container: Control
@export var _interval_in_seconds: float = 1
@export var _letters_per_seconds: float = 60

@export var _len_s: Array[int]


@export var should_run := false

@export var sounds: Array[AudioStream] = [
	preload("res://assets/audio/writing1.wav"),
	preload("res://assets/audio/writing2.wav"),
	preload("res://assets/audio/writing3.wav"),
	preload("res://assets/audio/writing4.wav"),
	preload("res://assets/audio/writing5.wav"),
]

var is_ready := false

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
		return
	modulate.a = 0.0

func _prep() -> void: 
	await get_tree().process_frame
	
	var _i: int = 0
	while true:
		var cc: Control = _container.get_node_or_null(str(_i + 1))
		if cc:
			# Ensure full text is measured first
			cc.visible_characters = -1
			await get_tree().process_frame
			
			# jitter prevention
			cc.custom_minimum_size = cc.size
			
			_contained_labels.append(cc)
			_len_s.append(len(cc.text))
			
			cc.visible_characters = 0
			_i += 1
		else:
			break
	
	modulate.a = 1.0
	_allowed = true

func _process(delta: float) -> void:
	if _allowed:
		if should_run:
			#makeshift loop
			_time_passed += delta
			if _time_passed >= _interval_in_seconds:
				if not _continue_disabled:
					_continue_disabled = true
					_continue()
	elif is_visible_in_tree() and not is_ready:
		is_ready = true
		_prep()

func _continue() -> void:
	if _current_iteration < len(_contained_labels):
		var cc: Control = _contained_labels[_current_iteration]
		_typewrite(cc)
	else:
		if not _ended:
			_end_process()
			_ended = true

func _typewrite(item: CanvasItem) -> void:
	var currsound := AudioStreamPlayer.new()
	add_child(currsound)
	currsound.stream = sounds[randi_range(0, 4)]
	currsound.play()
	
	var tween := item.create_tween()
	var str_length:int = _len_s[_current_iteration]
	tween.tween_property(item, "visible_characters", str_length, str_length / _letters_per_seconds)
	
	await tween.finished
	currsound.queue_free()
	_continue_disabled = false
	_time_passed = 0
	_current_iteration += 1

func _end_process() -> void:
	if not _ended:
		process_mode = Node.PROCESS_MODE_DISABLED
		sheet_finished.emit(name)
		_ended = true
		
func start():
	should_run = true
