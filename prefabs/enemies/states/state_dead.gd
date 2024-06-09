class_name StateDead
extends State

func _ready():
	state_name = "DEAD"

func during_physics_process(_delta):
	pass

func on_state_leave():
	pass

func on_state_enter():
	behavior.character_mover.set_move_dir(Vector3.ZERO)
