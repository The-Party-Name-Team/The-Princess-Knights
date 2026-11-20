extends Node
class_name PlayerData

@export var gold: int = 3
@export var glory: int = 0
@export var gospel: int = 0

func add_gold(amount: int):
	gold+=amount
