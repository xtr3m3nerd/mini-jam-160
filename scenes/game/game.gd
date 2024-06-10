extends Node3D
class_name Game

@onready var environment = $Environment
@onready var player = $Player

var current_level = null

func _ready():
	MusicManager.play_game_music()
	load_level(SceneManager.current_level)

func load_level(level: PackedScene) -> void:
	if current_level:
		environment.remove_child(current_level)
		current_level.queue_free()
	current_level = level.instantiate() as Level
	current_level.level_finished.connect(next_level)
	environment.add_child(current_level)
	player.global_transform = current_level.player_spawn.global_transform

func next_level():
	load_level(SceneManager.next_level())
