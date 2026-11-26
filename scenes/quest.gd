extends Control

@export var _win_stats: Dictionary[String, int]
@export var _lose_stats: Dictionary[String, int]

@export var _dice_textures: Array[Texture]
@export var _knight_textures: Dictionary[String, Texture]

@export var _dice: TextureRect

@export var _knight: Control

@export var _initial_roll_int: float = 0.1
@export var _final_roll_int: float = 1
var _roll_interval: float

@export var _player_data:PlayerData

@export var _current_val:int

@export var _result_val:int

var _slowed_down:= false
var _roll_time:float = 0
var _time_taken:float = 0

var _time_after_change:float = 0

var _rolled := false

func _ready() -> void:
	_roll_interval = _initial_roll_int
	if _dice == null:
		_dice = get_node_or_null("Dice")
	_roll_time = randf()*3 ###the time that it rolls
	
func _process(delta: float) -> void:
	_time_taken+=delta
	
	#roll
	if _time_taken >= _roll_time && not _slowed_down:
		_slow_roll()
		
func _physics_process(delta: float) -> void:
	if not _rolled:
		if _slowed_down:
			_roll_interval += (_final_roll_int-_initial_roll_int)/300 ##slowingdownfactor
			if _roll_interval >= _final_roll_int:
				_pick_result()
				_roll_interval = 999
		
		if _time_after_change >= _roll_interval-.05:
			_change_dice()
			print(_current_val)
			_time_after_change=0
	
		_time_after_change += delta

func _slow_roll() -> void:
	_slowed_down = true
	
func _change_dice():
	_current_val = randi_range(1, 6)
	var tween:= _dice.create_tween()
	tween.tween_property(_dice, "scale", Vector2(.11, .11), .05)
	await tween.finished
	_dice.scale = Vector2(.1, .1)
	_dice.texture = _dice_textures[_current_val-1]

func _pick_result():
	_result_val = _current_val
	var tween:= _dice.create_tween()
	tween.tween_property(_dice, "scale", Vector2(.15, .15), .25)
	_rolled = true
	_fail()
	
func _success():
	pass

func _fail():
	#values
	
	for x in _lose_stats:
		match x:
			"Gold":
				_player_data.add_Gold(_lose_stats.get(x))
	
	#animation
	var twen:=_dice.create_tween()
	twen.tween_property(_dice, "position", _dice.position+Vector2(0, 500), 1)
	await twen.finished
	_knight.visible = true
	
	var twen2:= _knight.create_tween()
	twen2.tween_property(_knight, "self_modulate:a", 1.0, .5)
	await twen2.finished
	
	var initpos:= _knight.position
	for x in range(0, 4):
		twen2 = _knight.create_tween()
		twen2.tween_property(_knight, "position", initpos+Vector2(10-2*x, 0), .1)
		await twen2.finished
		twen2 = _knight.create_tween()
		twen2.tween_property(_knight, "position", initpos-Vector2(10-2*x, 0), .1)
		await twen2.finished
	_knight.position = initpos
