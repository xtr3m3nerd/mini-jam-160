extends Control

@onready var level_1 = $MarginContainer/VBoxContainer/Spacer/PanelContainer/MarginContainer/GridContainer/Level1
@onready var back_button = $MarginContainer/VBoxContainer/BackButton
@onready var menu: Menu
@onready var level_2 = $MarginContainer/VBoxContainer/Spacer/PanelContainer/MarginContainer/GridContainer/Level2
@onready var level_3 = $MarginContainer/VBoxContainer/Spacer/PanelContainer/MarginContainer/GridContainer/Level3
@onready var level_4 = $MarginContainer/VBoxContainer/Spacer/PanelContainer/MarginContainer/GridContainer/Level4

func _ready():
	UiSfxManager.add_button(level_1)
	UiSfxManager.add_button(level_2)
	UiSfxManager.add_button(level_3)
	UiSfxManager.add_button(level_4)
	UiSfxManager.add_button(back_button)
	level_1.grab_focus()
	menu = get_parent() as Menu

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		menu.change_to_main_menu()

func _on_level_1_pressed():
	SceneManager.play_game_with_level(0)

func _on_level_2_pressed():
	SceneManager.play_game_with_level(1)

func _on_level_3_pressed():
	SceneManager.play_game_with_level(2)

func _on_level_4_pressed():
	SceneManager.play_game_with_level(3)

func _on_back_button_pressed():
	menu.change_to_main_menu()
