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


func _on_death_zone_body_entered(body):
	if body.has_method("hurt"):
		var damage_data = DamageData.new()
		damage_data.amount = 1000000
		damage_data.hit_pos = Vector3.ZERO
		body.hurt(damage_data)


func _on_win_zone_body_entered(body):
	if body.is_in_group("player"):
		SceneManager.change_to_win_screen()
