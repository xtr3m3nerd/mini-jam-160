class_name WeaponManager
extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var weapons = $Weapons.get_children()
var weapons_unlocked = []
var cur_slot = 0
var cur_weapon = null

func _ready():
	for weapon in weapons:
		if weapon.has_method("set_bodies_to_exclude"):
			weapon.set_bodies_to_exclude([get_parent().get_parent()])
	disable_all_weapons()
	for _i in range(weapons.size()):
		weapons_unlocked.append(true)
	switch_to_weapon_slot(0)

func attack(input_just_pressed: bool, input_held: bool):
	if cur_weapon is Weapon:
		cur_weapon.attack(input_just_pressed, input_held)

func disable_all_weapons():
	for weapon in weapons:
		if weapon.has_method("set_active"):
			weapon.set_active(false)
		else:
			weapon.hide()

func switch_to_previous_weapon():
	for i in range(weapons.size()):
		var wrapped_ind = wrapi(cur_slot - 1 - i, 0, weapons.size())
		if switch_to_weapon_slot(wrapped_ind):
			break

func switch_to_next_weapon():
	for i in range(weapons.size()):
		var wrapped_ind = wrapi(cur_slot + 1 + i, 0, weapons.size())
		if switch_to_weapon_slot(wrapped_ind):
			break

func switch_to_weapon_slot(slot_ind: int)->bool:
	if slot_ind >= weapons.size() or slot_ind < 0:
		return false
	if weapons_unlocked.size() == 0 or !weapons_unlocked[slot_ind]:
		return false
	disable_all_weapons()
	cur_slot = slot_ind
	cur_weapon = weapons[cur_slot]
	if cur_weapon.has_method("set_active"):
		cur_weapon.set_active(true)
	else:
		cur_weapon.show()
	return true

func update_animation(velocity: Vector3, grounded: bool):
	if cur_weapon is Weapon and !cur_weapon.is_idle():
		animation_player.play("RESET")
	elif !grounded or velocity.length() < 5.0:
		animation_player.play("RESET", 0.3)
	else:
		animation_player.play("moving", 0.3)
		
