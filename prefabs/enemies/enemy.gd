class_name Enemy
extends CharacterBody3D

@onready var collision_shape_3d = $CollisionShape3D
@onready var graphics = $Graphics as Node3D
@onready var animation_player = $Graphics/AnimationPlayer as AnimationPlayer
@onready var health_manager = $HealthManager as HealthManager
@onready var character_mover = $CharacterMover as CharacterMover
@onready var footsteps = $Footsteps as Footsteps
@onready var screech = $Screech as RandomAudioStreamPlayer3D

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var game_manager : GameManager = get_tree().get_first_node_in_group("game_manager")
@onready var behavior: Behavior = null

var dead = false

func _ready():
	health_manager.died.connect(kill)
	animation_player.animation_finished.connect(on_animation_finished)
	character_mover.moved.connect(footsteps.on_character_mover_moved)
	await get_tree().create_timer(randf_range(0.0,1.0)).timeout
	animation_player.stop()
	animation_player.play("idle", 0.5)
	if game_manager:
		#health_manager.dead.connect(game_manager.add_kill)
		pass
	for child in get_children():
		if child.is_in_group("enemy_behaviors"):
			behavior = child

func kill():
	dead = true
	#$DeathSound.play()
	animation_player.play("death", 0.5, 0.5)
	collision_shape_3d.disabled = true

func hurt(damage):
	health_manager.hurt(damage)

func get_pushed(force: float, direction: Vector3):
	behavior.change_state("STUNNED")
	velocity = direction*force
	velocity.y = 0

func on_animation_finished(anim_name):
	match anim_name:
		"attack":
			animation_player.play("idle", 0.5)
		_:
			pass


func _on_melee_flank_behavior_state_changed(current_state, new_state):
	if new_state.state_name == "CHASE":
		screech.play_random()