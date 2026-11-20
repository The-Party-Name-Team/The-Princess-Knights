extends Label

@export var plr_data: PlayerData = null

func _process(delta: float) -> void:
	text = str(plr_data.gold)
