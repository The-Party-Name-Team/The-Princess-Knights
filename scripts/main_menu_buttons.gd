extends Button

#exported properties
@export var _event_textures: Dictionary[String, Texture2D] = {
	"base": null,
	"hover": null
}
@export var _texture_label: TextureRect

@export var _hover_anim_duration: float = 0.1

@export var _how_much_rise: float = 20

#properties
var _init_position: Vector2 #before rising
var _final_position: Vector2 #after rising

func _ready() -> void:	
	if not _texture_label == null:
		mouse_entered.connect(_on_mouse_enter)
		mouse_exited.connect(_on_mouse_exit)
		
		if _event_textures.get("hover") == null:
			_event_textures.base = _texture_label.texture
			
		await get_tree().process_frame
		_init_position = _texture_label.position
		_final_position = _init_position + Vector2(0, -_how_much_rise)
	
func _on_mouse_enter() -> void:
	if not _event_textures.get("hover") == null:
		_texture_label.texture = _event_textures.get("hover")
		var _btn_tween := _texture_label.create_tween()
		_btn_tween.tween_property(_texture_label, "position", _final_position, _hover_anim_duration)
	
func _on_mouse_exit() -> void:
	if not _event_textures.get("base") == null:
		_texture_label.texture = _event_textures.get("base")
		var _btn_tween := _texture_label.create_tween()
		_btn_tween.tween_property(_texture_label, "position", _init_position, _hover_anim_duration)
