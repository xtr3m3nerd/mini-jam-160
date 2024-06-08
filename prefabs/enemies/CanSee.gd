extends MeshInstance3D

@export var behavior: Behavior

@export var seen_material: Material
@export var unseen_material: Material

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if behavior.is_player_seen:
		set_surface_override_material(0, seen_material)
	else:
		set_surface_override_material(0, unseen_material)
