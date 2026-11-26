extends TextureRect

@export var _Container: Control = null
@export var _Player_Data: Resource = null

var _Gold_UI: Label = null
var _Glory_UI: Label = null
var _Gospel_UI: Label = null

func _ready():
	var has_container:= false
	var has_plr_data := false
	
	if _Container != null:
		_Gold_UI = _Container.get_node_or_null("Gold")
		_Glory_UI = _Container.get_node_or_null("Glory")
		_Gospel_UI = _Container.get_node_or_null("Gospel")
		has_container = true
	
	if _Player_Data != null:
		_Player_Data.changed.connect(update_ui)
		has_plr_data = true

func update_ui() -> void:
	_Gold_UI.text = str(_Player_Data._Gold)
	_Glory_UI.text = str(_Player_Data._Glory)
	_Gospel_UI.text = str(_Player_Data._Gospel)
	
