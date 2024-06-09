extends Node3D
class_name PickupManager

@onready var ray_cast_3d = $RayCast3D as RayCast3D

var pickup_in_hand = null

func pickup(input_just_pressed: bool):
	if input_just_pressed:
		ray_cast_3d.enabled = true
		ray_cast_3d.force_raycast_update()
		if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("pickup"):
			pickup_in_hand = ray_cast_3d.get_collider().pickup()
			print(pickup_in_hand)
		ray_cast_3d.enabled = false
