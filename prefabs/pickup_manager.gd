extends Node3D
class_name PickupManager

@onready var ray_cast_3d = $RayCast3D as RayCast3D
@onready var color_rect = $CanvasLayer/ColorRect

var pickup_in_hand = null

func _ready():
	color_rect.hide()

func pickup(input_just_pressed: bool):
	if input_just_pressed:
		ray_cast_3d.enabled = true
		ray_cast_3d.force_raycast_update()
		if ray_cast_3d.is_colliding():
			if ray_cast_3d.get_collider().has_method("pickup") and pickup_in_hand == null:
				pickup_in_hand = ray_cast_3d.get_collider().pickup()
				print(pickup_in_hand)
				color_rect.show()
				
			if pickup_in_hand != null and ray_cast_3d.get_collider().has_method("dropoff"):
				ray_cast_3d.get_collider().dropoff(pickup_in_hand)
				pickup_in_hand = null
				color_rect.hide()
		
		ray_cast_3d.enabled = false
