extends Node3D

@export var base_material: Material
@onready var mesh_instance = $RootNode/pCube12 as MeshInstance3D
@onready var omni_light_3d = $OmniLight3D as OmniLight3D

@export var color: Color = Color.RED:
	set(c):
		color = c
		update_color(c)

func _ready():
	mesh_instance.material_overlay = base_material.duplicate()
	update_color(color)

func update_color(c):
	if omni_light_3d == null:
		return
	omni_light_3d.light_color = c
	mesh_instance.material_override.albedo_color = c
	mesh_instance.material_override.emission = c

