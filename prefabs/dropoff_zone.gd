extends Area3D

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var label_3d = $Label3D
@onready var base_orb = $BaseOrb

var can_dropoff = true
var can_drop_message = "Press 'E' to drop off"
var cant_drop_message = "Looks like you can put something here"

func dropoff(color: Color):
	print("Dropped off " + str(color))
	base_orb.color = color
	base_orb.show()
	label_3d.hide()

func _ready():
	base_orb.hide()
	label_3d.hide()

func _on_body_entered(body):
	if body == player and not base_orb.is_visible_in_tree():
		if player.pickup_manager.pickup_in_hand == null:
			label_3d.text = cant_drop_message
		else:
			label_3d.text = can_drop_message
			can_dropoff = true
		label_3d.show()

func _on_body_exited(body):
	if body == player:
		label_3d.hide()
		can_dropoff = false
