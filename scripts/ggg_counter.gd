extends TextureRect

@export var _Container: Control = null
@export var _Player_Data: Player = null

var _Gold_UI: Label = null
var _Glory_UI: Label = null
var _Gospel_UI: Label = null

var _Ready_to_Run: bool = false

func _ready():
	var has_container:= false
	var has_plr_data := false
	
	if _Container != null:
		_Gold_UI = _Container.get_node_or_null("Gold")
		_Glory_UI = _Container.get_node_or_null("Glory")
		_Gospel_UI = _Container.get_node_or_null("Gospel")
		has_container = true
	
	if _Player_Data != null:
		_Player_Data.gold_changed.connect(_update_gold)
		has_plr_data = true
		
	_Ready_to_Run = has_container and has_plr_data
	if _Ready_to_Run:
		_update_gold()
		_update_glory()
		_update_gospel()

func _update_gold() -> void:
	_Gold_UI.text = str(_Player_Data._Gold)
	
func _update_glory() -> void:
	_Glory_UI.text = str(_Player_Data._Glory)
	
func _update_gospel() -> void:
	_Gospel_UI.text = str(_Player_Data._Gospel)
