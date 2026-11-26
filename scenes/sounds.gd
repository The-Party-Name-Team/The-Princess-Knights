extends HSlider

@export var audio_bus_name: String
@export var player_data: Resource

var audio_bus_id

func _ready() :
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	value = db_to_linear(AudioServer.get_bus_volume_db(audio_bus_id))

@warning_ignore("shadowed_variable_base_class")
func _on_value_changed(value) :
	var _db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, _db)
