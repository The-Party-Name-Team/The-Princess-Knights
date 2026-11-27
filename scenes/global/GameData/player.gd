extends Node

@export var player_data: PlayerData

const backup_path: String = "res://data/player_data.tres"

signal val_changed

func _ready() -> void:
	if player_data == null:
		load_data()

func load_data():
	if ResourceLoader.exists(backup_path):
		player_data = ResourceLoader.load(backup_path) as PlayerData
	else:
		player_data = preload(backup_path).duplicate()
		
	player_data.val_changed.connect(transmit_change)
	
func transmit_change():
	val_changed.emit()

func get_data():
	return [player_data.Gold, player_data.Glory, player_data.Gospel]

func add_Gold(amount: int):
	player_data.Gold+=amount

func add_Glory(amount: int):
	player_data.Glory+=amount
	
func add_Gospel(amount: int):
	player_data.Gospel+=amount
