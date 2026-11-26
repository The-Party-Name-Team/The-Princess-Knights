extends Node2D

@onready var level_buttons_container = $levelbuttons
@onready var description_label: Label = $DescriptionLabel

const UNLOCKED_TEXTURE: Texture2D = preload("res://assets/visuals/UI/buttons/base/map-levelpoint.png")
const LOCKED_TEXTURE: Texture2D = preload("res://assets/visuals/UI/buttons/hover/map-levelpoint-hover.png")

var level_descriptions: Array[String] = [
	"Mission 1\nAre those...? (1)",
	"Mission 2\nA Village...  (6)",
	"Mission 3\nLook! A Wagon! (2)",
	"Mission 4\nA... child? (7)",
	"Mission 5\nThe Guard and The Border... Guard Border! (3)",
	"Mission 6\nShortcut! (8)",
	"Mission 7\nHelp! (4)",
	"Mission 8\nThe Stray (9)",
	"Mission 9\nTwo Farmers Under The Tree... Arguing... (5)"
]

var level_scenes: Array[String] = [
	"res://scenes/mainmenu.tscn",
	"res://scenes/mainmenu.tscn",
	"res://scenes/main_scene/game.tscn",
	"res://scenes/main_scene/game.tscn",
	"res://scenes/main_scene/game.tscn",
	"res://scenes/main_scene/game.tscn",
	"res://scenes/main_scene/game.tscn",
	"res://scenes/main_scene/game.tscn",
	"res://scenes/mainmenu.tscn"
]

func _ready() -> void:
	description_label.text = "Hover over an available level to see details."
	setup_levels()
	
func setup_levels() -> void:
	var level_index: int = 0
	
	for child in level_buttons_container.get_children():
		if not child is Button or not child.name.begins_with("level"):
			continue
			
		var btn: Button = child
		var level_num: int = level_index + 1
		
		# Use CanvasItem so it works with TextureRect (levelicon, levelicon2, etc.)
		var sprite: CanvasItem = null
		for btn_child in btn.get_children():
			if btn_child is Sprite2D or btn_child is TextureRect:
				sprite = btn_child
				break
		
		btn.disabled = level_num > Global.unlocked_level
		
		# Levels 2 to 8: White ball when locked, Red ball when unlocked
		if sprite and level_num > 1 and level_num <= 9:
			if level_num > Global.unlocked_level:
				sprite.texture = LOCKED_TEXTURE
			else:
				sprite.texture = UNLOCKED_TEXTURE
			sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
		elif sprite:
			# Level 1 (Crown) & Level 9 (Castle)
			if level_num > Global.unlocked_level:
				sprite.modulate = Color(0.5, 0.5, 0.5, 0.8)
			else:
				sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
		
		btn.mouse_entered.connect(_on_level_hovered.bind(level_index))
		btn.pressed.connect(_on_level_pressed.bind(level_index))
		
		level_index += 1

func _on_level_hovered(index: int) -> void:
	var level_num: int = index + 1
	
	if level_num <= Global.unlocked_level:
		$Buttonhover.play()
		description_label.text = level_descriptions[index]
	else:
		description_label.text = "Level %d is locked. Complete Level %d first." % [level_num, level_num - 1]

func _on_level_pressed(index: int) -> void:
	$Buttonclick.play()
	await get_tree().create_timer(0.2).timeout
	Global.selected_level = index + 1
	get_tree().change_scene_to_file(level_scenes[index])

func _on_exit_pressed() -> void:
	$Buttonclick.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

func _on_exit_mouse_entered() -> void:
	$Buttonhover.play()
