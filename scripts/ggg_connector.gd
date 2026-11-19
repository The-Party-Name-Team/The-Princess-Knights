extends Node
class_name GGGConnector

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("first_dialog")
	
func _check_type(type: int, data: Variant):
	if typeof(data) == type:
		return true
	return false
	
func _on_dialogic_signal(argument: Variant):
	if argument is Dictionary:
		match argument.get("id"):
			"add_gold":
				if argument.get("qty"):
					if _check_type(TYPE_FLOAT, argument.get("qty")):
						print(type_string(typeof(argument.get("qty"))))
						_add_gold(argument.get("qty"))
			
func _add_gold(amount: int):
	print("Added %d amounts of gold!" % amount)

func _add_glory(amount: int):
	pass
	
func _add_gospel(amount: int):
	pass
