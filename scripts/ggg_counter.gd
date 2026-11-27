extends Control

@export var _Container: Control = null

var _Gold_UI: Label = null
var _Glory_UI: Label = null
var _Gospel_UI: Label = null

var has_container:= false

func _ready():
	
	if _Container != null:
		_Gold_UI = _Container.get_node_or_null("Gold")
		_Glory_UI = _Container.get_node_or_null("Glory")
		_Gospel_UI = _Container.get_node_or_null("Gospel")
		has_container = true
	
	Player.val_changed.connect(update_ui)

func update_ui() -> void:
	if has_container:
		var data = Player.get_data()
		_Gold_UI.text = str(data[0])
		_Glory_UI.text = str(data[1])
		_Gospel_UI.text = str(data[2])
	
