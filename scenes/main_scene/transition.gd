extends Control
class_name TransitionScreen

signal finished
@export var init_black := false

func _ready() -> void:
	if init_black:
		modulate.a = 1

func inter_fade():
	var twn := create_tween()
	twn.tween_property(self, "modulate:a", 1, 1)
	await twn.finished
	twn = create_tween()
	twn.tween_property(self, "modulate:a", 1, 1)
	finished.emit()
	twn = create_tween()
	twn.tween_property(self, "modulate:a", 0, 2)

func cross_fade():
	var twn := create_tween()
	twn.tween_property(self, "modulate:a", 1, .8)
	twn = create_tween()
	twn.tween_property(self, "modulate:a", 0, 1.2)
	finished.emit()
