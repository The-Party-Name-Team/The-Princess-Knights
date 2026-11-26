extends Control

const OPTIONS_SCENE = preload("res://scenes/options.tscn")
var options_instance: Node = null

func _ready():
	hide()

func resume():
	get_tree().paused = false
	$pausinganimation.play_backwards('blur')
	await $pausinganimation.animation_finished
	hide()
	
func pause():
	show()
	get_tree().paused = true  
	$pausinganimation.play('blur')

func testPause():
	if is_instance_valid(options_instance):
		return
		
	if Input.is_action_just_pressed('pause') and get_tree().paused == false :
		pause()
	elif Input.is_action_just_pressed('pause') and get_tree().paused == true :
		resume()

func _on_resume_pressed() -> void:
	$Buttonclick2.play()
	await get_tree().create_timer(0.2).timeout
	resume()
	
func _on_quit_pressed() -> void:
	$Buttonclick2.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	
func _process(_delta):
	testPause()

func _on_options_pressed() -> void:
	$Buttonclick2.play()
	await get_tree().create_timer(0.2).timeout
	if not is_instance_valid(options_instance):
		options_instance = OPTIONS_SCENE.instantiate()
		add_child(options_instance)
		

func _on_resume_mouse_entered() -> void:
	$Buttonhover.play()

func _on_options_mouse_entered() -> void:
	$Buttonhover.play()

func _on_quit_mouse_entered() -> void:
	$Buttonhover.play()
