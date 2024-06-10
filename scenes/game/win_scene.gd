extends Node

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed():
	SceneManager.change_to_menu()
