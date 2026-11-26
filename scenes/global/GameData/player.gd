extends Node

@export var player_data: PlayerData

const backup_path: String = "res://data/player_data.tres"

func _ready() -> void:
	if player_data == null:
		load_data()

func load_data():
	if ResourceLoader.exists(backup_path):
		player_data = ResourceLoader.load(backup_path) as PlayerData
	else:
		player_data = preload(backup_path).duplicate()

func add_Gold(amount: int):
	player_data.Gold+=amount

func add_Glory(amount: int):
	player_data.Glory+=amount
	
func add_Gospel(amount: int):
	player_data.Gospel+=amount
