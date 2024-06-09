extends Area3D

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var label_3d = $Label3D
@export var color: Color = Color.BLUE
@onready var base_orb = $BaseOrb

var can_pickup=false

func pickup():
	queue_free()
	return color

func _ready():
	label_3d.hide()
	base_orb.color = color

func _on_body_entered(body):
	if body == player:
		base_orb.color = color
		label_3d.show()
		can_pickup = true

func _on_body_exited(body):
	if body == player:
		label_3d.hide()
		can_pickup = false
