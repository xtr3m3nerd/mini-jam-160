class_name CharacterMover
extends Node3D

@export var jump_force = 15.0
@export var gravity = 30.0

@export var default_max_speed = 15.0
@export var move_accel = 4.0
@export var stop_drag = 0.9

var character_body : CharacterBody3D
var move_drag = 0.0
var move_dir : Vector3

signal moved(velocity: Vector3, grounded: bool)

func _ready():
	character_body = get_parent()
	update_drag(default_max_speed)

func update_drag(new_max_speed: float) -> void:
	move_drag = float(move_accel) / new_max_speed

func set_move_dir(new_move_dir: Vector3, new_max_speed: float = 0.0):
	move_dir = new_move_dir
	if new_max_speed != 0.0:
		update_drag(new_max_speed)
	else:
		update_drag(default_max_speed)

func jump():
	if character_body.is_on_floor():
		character_body.velocity.y = jump_force

func _physics_process(delta):
	if character_body.velocity.y > 0.0 and character_body.is_on_ceiling():
		character_body.velocity.y = 0.0
	if not character_body.is_on_floor():
		character_body.velocity.y -= gravity * delta
	
	var drag = move_drag
	if move_dir.is_zero_approx():
		drag = stop_drag
	
	var flat_velo = character_body.velocity
	flat_velo.y = 0.0
	character_body.velocity += move_accel * move_dir - flat_velo * drag
	
	character_body.move_and_slide()
	moved.emit(character_body.velocity, character_body.is_on_floor())
