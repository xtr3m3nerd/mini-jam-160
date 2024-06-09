extends Node3D

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var label_3d = $Label3D

var can_pickup=false

func pickup():
	queue_free()
	return "RED_ORB"

func _ready():
	label_3d.hide()

func _on_body_entered(body):
	if body == player:
		label_3d.show()
		can_pickup = true

func _on_body_exited(body):
	if body == player:
		label_3d.hide()
		can_pickup = false
