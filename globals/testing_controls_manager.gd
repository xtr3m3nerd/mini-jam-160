extends Node

func _process(_delta):
	#if Input.is_action_just_pressed("quit"):
		#if OS.get_name() != "Web":
			#get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
