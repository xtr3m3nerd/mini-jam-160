extends Node3D

class_name Weapon

@onready var animation_player :AnimationPlayer = $Graphics/AnimationPlayer
@onready var bullet_emitter : BulletEmitter = $BulletEmitter
@onready var fire_point : Node3D = $FirePoint
@onready var ambient_sound = $AmbientSound

@export var automatic = false

@export var damage = 5
@export var ammo = 30

@export var attack_rate = 0.2
var last_attack_time = -9999.9

@export var animation_controlled_attack = false

signal fired
signal out_of_ammo

var held = false

func _ready():
	bullet_emitter.set_damage(damage)

func set_bodies_to_exclude(bodies: Array):
	bullet_emitter.set_bodies_to_exclude(bodies)

func attack(input_just_pressed: bool, input_held: bool):
	held = input_held
	if !automatic and !input_just_pressed:
		return
	if automatic and !input_held:
		return
	
	if ammo == 0:
		if input_just_pressed:
			out_of_ammo.emit()
		return
	
	var cur_time = Time.get_ticks_msec() / 1000.0
	if cur_time - last_attack_time < attack_rate:
		return
	
	if ammo > 0:
		ammo -= 1
	
	if !animation_controlled_attack:
		actually_attack()
	last_attack_time = cur_time
	animation_player.stop()
	animation_player.play("attack")
	if has_node("Graphics/MuzzleFlash"):
		$Graphics/MuzzleFlash.flash()

func actually_attack():
	bullet_emitter.global_transform = fire_point.global_transform
	bullet_emitter.fire()

func set_active(a: bool):
	$Crosshairs.visible = a
	visible = a
	if !a:
		animation_player.play("RESET")
	else:
		if animation_player.has_animation("pullout"):
			animation_player.play("pullout",0.3)
	if ambient_sound != null:
		if a:
			ambient_sound.play()
		else:
			ambient_sound.stop()

func is_idle() -> bool:
	return !animation_player.is_playing()

func start_moving():
	if animation_player.current_animation != "attack":
		if animation_player.has_animation("moving"):
			animation_player.play("moving",0.3)

func stop_moving():
	if animation_player.current_animation != "attack":
		pass
		#animation_player.stop()

func check_stop():
	if !held:
		animation_player.stop()
