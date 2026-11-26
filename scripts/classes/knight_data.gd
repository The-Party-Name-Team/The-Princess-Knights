extends Node
class_name KnightData

@export var max_HP: int = 5
var HP: int:
	set(val):
		HP = max(0, val)
		HP = min(max_HP, HP)

var thematic_sound: AudioStreamPlayer

@export var STATS: Dictionary[String, int] = {
	"STR": 1,
	"AGI": 1,
	"WIS": 1,
	"INT": 1,
	"CHA": 1,
}

@export var Relations: int = 0

func take_damage(amount:int):
	HP-=amount
	
func change_relation(amount:int):
	if amount>0:
		if thematic_sound != null:
			thematic_sound.play()
	Relations+=amount
	
func get_stat(key: String):
	return STATS.get(key)
