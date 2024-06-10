extends Area3D

@onready var animation_player = $AnimationPlayer
var opened = false

func interact():
	if opened:
		animation_player.play("close")
		opened = false
	else:
		animation_player.play("open")
		opened = true
