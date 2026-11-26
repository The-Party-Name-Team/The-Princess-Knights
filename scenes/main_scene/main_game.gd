extends Node2D

#HUD items
@export var HUD: Control
var has_HUD := false

func _ready() -> void:
	if HUD != null:
		has_HUD = true

func toggle_hud() -> void:
	if has_HUD:
		HUD.visible = !HUD.visible
	else:
		print("No HUD has been assigned in Main Game Scene.")
