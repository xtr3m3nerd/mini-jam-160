class_name Player
extends CharacterBody3D

@onready var camera_3d = $Camera3D 
@onready var character_mover = $CharacterMover as CharacterMover
@onready var health_manager = $HealthManager as HealthManager
@onready var weapon_manager = $Camera3D/WeaponManager as WeaponManager
@onready var footsteps = $Footsteps as Footsteps

@export var mouse_sensitivity_h = 0.15
@export var mouse_sensitivity_v = 0.15


const HOTKEYS = {
	KEY_1: 0,
	KEY_2: 1,
	KEY_3: 2,
	KEY_4: 3,
	KEY_5: 4,
	KEY_6: 5,
	KEY_7: 6,
	KEY_8: 7,
	KEY_9: 8,
	KEY_0: 9,
}

var dead = false



func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	health_manager.died.connect(kill)
	character_mover.moved.connect(footsteps.on_character_mover_moved)

func _input(event):
	if dead:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity_h
		camera_3d.rotation_degrees.x -= event.relative.y * mouse_sensitivity_v
		camera_3d.rotation_degrees.x = clamp(camera_3d.rotation_degrees.x, -90, 90)
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			weapon_manager.switch_to_previous_weapon()
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			weapon_manager.switch_to_next_weapon()
	if event is InputEventKey and event.pressed and event.keycode in HOTKEYS:
		weapon_manager.switch_to_weapon_slot(HOTKEYS[event.keycode])

func _process(_delta):
	#if Input.is_action_just_pressed("fullscreen"):
		#var fs = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
		#if fs:
			#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		#else:
			#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	if dead:
		return
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var move_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	character_mover.set_move_dir(move_dir)
	if Input.is_action_just_pressed("jump"):
		character_mover.jump()
	
	weapon_manager.attack(Input.is_action_just_pressed("main_action"), Input.is_action_pressed("main_action"))

func kill():
	dead = true
	character_mover.set_move_dir(Vector3.ZERO)

func hurt(damage_data: DamageData):
	health_manager.hurt(damage_data)

