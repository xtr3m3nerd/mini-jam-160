extends Node

@export var game_scene: PackedScene
@export var levels: Array[PackedScene]
@export var main_menu_scene: PackedScene

var current_level: PackedScene

func change_to_menu() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)

func play_game_with_level(level: int) -> void:
	current_level = levels[level]
	get_tree().change_scene_to_packed(game_scene)

func next_level():
	var index = levels.find(current_level)
	current_level = levels[index + 1]
	return current_level
