class_name CharacterMover
extends Node3D

@export var jump_force = 15.0
@export var gravity = 30.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var default_max_speed = 15.0
var max_speed = 0.0
@export var air_speed_ratio = 0.9
@export var move_accel = 4.0
@export var stop_drag = 0.9

var character_body : CharacterBody3D
var move_drag = 0.0
var move_dir : Vector3

var is_frozen = false

signal moved(velocity: Vector3, grounded: bool)

func _ready():
	character_body = get_parent()
	update_drag(default_max_speed)

func update_drag(new_max_speed: float) -> void:
	move_drag = float(move_accel) / new_max_speed

func set_move_dir(new_move_dir: Vector3, new_max_speed: float = 0.0):
	move_dir = new_move_dir
	if new_max_speed != 0.0:
		max_speed = new_max_speed
		update_drag(new_max_speed)
	else:
		max_speed = default_max_speed
		update_drag(default_max_speed)

func jump():
	if character_body.is_on_floor():
		character_body.velocity.y = jump_force

func _physics_process(delta):
	if is_frozen: 
		return
	#if character_body.velocity.y > 0.0 and character_body.is_on_ceiling():
		#character_body.velocity.y = 0.0
	#if not character_body.is_on_floor():
		#character_body.velocity.y -= gravity * delta
	#
	#var drag = move_drag
	#if move_dir.is_zero_approx():
		#drag = stop_drag
	#
	#var flat_velo = character_body.velocity
	#flat_velo.y = 0.0
	#character_body.velocity += move_accel * move_dir - flat_velo * drag
	
	if character_body.is_on_floor():
		character_body.velocity = accelerate(move_dir, delta, move_accel*10, max_speed)
		#Apply friction
		#var flat_velo = character_body.velocity
		#flat_velo.y = 0.0
		#character_body.velocity -= flat_velo * drag
		var speed = character_body.velocity.length()
		if speed != 0:
			var drop = speed * 5 * delta
			character_body.velocity *= max(speed - drop, 0) / speed
	else:
		character_body.velocity = accelerate(move_dir, delta, move_accel * air_speed_ratio * 10, max_speed * air_speed_ratio)
		character_body.velocity.y -= gravity * delta
	
	character_body.move_and_slide()
	moved.emit(character_body.velocity, character_body.is_on_floor())

func freeze():
	is_frozen = true
	
func unfreeze():
	is_frozen = false

func accelerate(dir, delta, accel_type, max_velocity):
	var proj_vel = character_body.velocity.dot(dir)
	var accel_vel = accel_type * delta
	
	if (proj_vel + accel_vel > max_velocity):
		accel_vel = max_velocity - proj_vel
	
	return character_body.velocity + (dir * accel_vel)
