extends Resource
class_name PlayerData

@export var Gold: int = 0:
	set(val):
		Gold = max(0, val)
		
@export var Glory: int = 0:
	set(val):
		Glory = max(0, val)
		
@export var Gospel: int = 0:
	set(val):
		Gospel = max(0, val)

func add_Gold(amount: int):
	Gold+=amount

func add_Glory(amount: int):
	Glory+=amount
	
func add_Gospel(amount: int):
	Gospel+=amount
