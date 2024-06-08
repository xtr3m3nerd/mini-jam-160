extends Control

@onready var back_button = $MarginContainer/VBoxContainer/BackButton
@onready var menu: Menu = get_parent() as Menu

func _ready():
	back_button.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		menu.change_to_main_menu()

func _on_back_button_pressed():
	menu.change_to_main_menu()
