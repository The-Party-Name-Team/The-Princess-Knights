extends Control

func resume():
	get_tree().paused = false
	$pausinganimation.play_backwards('pausing')
	
func pause():
	get_tree().paused = true  
	$pausinganimation.play('pausing')

func testPause():
	if Input.is_action_just_pressed('pause') and get_tree().paused == false :
		pause()
	elif Input.is_action_just_pressed('pause') and get_tree().paused == true :
		resume()

func _on_resume_pressed() -> void:
	resume()
	
func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	
	
func _process(_delta):
	testPause()
