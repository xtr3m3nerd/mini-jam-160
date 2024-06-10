class_name Level
extends Node3D

signal level_finished

@onready var player_spawn = $PlayerSpawn

@export var needed_orbs = 3
var collected_orbs = 0

func _on_dropped_off():
	collected_orbs += 1
	print(collected_orbs)
	if collected_orbs >= needed_orbs:
		level_finished.emit()
