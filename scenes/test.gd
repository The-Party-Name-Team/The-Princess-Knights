extends Camera2D

@export var pos1:Node2D
@export var pos2:Node2D
@export var btn:Button

func _ready() -> void:
	offset = pos1.position
	btn.pressed.connect(move)

func move():
	print("clicked")
	var tween:= create_tween()
	tween.tween_property(self, "position", pos2.position, 1)
