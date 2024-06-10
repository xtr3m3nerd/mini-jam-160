class_name State
extends Node

@export var state_name: String = ""
@onready var behavior: Behavior = get_parent() as Behavior

func during_physics_process(_delta):
	pass

func on_state_leave():
	pass

func on_state_enter():
	pass
