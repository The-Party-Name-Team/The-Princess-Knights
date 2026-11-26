extends Resource
class_name PlayerData

@export var _Gold: int = 0:
	set(val):
		_Gold = max(0, val)
		
@export var _Glory: int = 0:
	set(val):
		_Glory = max(0, val)
		

@export var _Gospel: int = 0:
	set(val):
<<<<<<< Updated upstream
		_Gospel = max(0, val)


func add_gold(amount: int):
	_Gold+=amount

func add_glory(amount: int):
	_Glory+=amount
	
func add_gospel(amount: int):
	_Gospel+=amount
=======
		Gospel = max(0, val)
>>>>>>> Stashed changes
