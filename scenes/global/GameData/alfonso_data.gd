extends KnightData

var themeaudio:Resource = preload("res://assets/audio/option_alfonso.wav")

func _ready():
	thematic_sound = AudioStreamPlayer.new()
	thematic_sound.stream = themeaudio
	add_child(thematic_sound)
