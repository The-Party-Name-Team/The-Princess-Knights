extends Label

@export var ref_label: Button
var rdy = false

func _ready():
	if ref_label != null:
		rdy = true

func _process(delta: float) -> void:
	if rdy:
		if ref_label.text != text:
			text = ref_label.text
