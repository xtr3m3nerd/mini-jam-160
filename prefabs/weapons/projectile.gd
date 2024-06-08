class_name Projectile
extends CharacterBody3D

@export var move_speed = 20.0
@export var damage = 5

@export var time_to_live = 5.0
var destroy_timer: Timer

func _ready() -> void:
	destroy_timer = Timer.new()
	destroy_timer.wait_time = time_to_live
	destroy_timer.one_shot = true
	destroy_timer.timeout.connect(_destroy_timeout)
	add_child(destroy_timer)
	destroy_timer.start()

func _physics_process(delta):
	var dir = -transform.basis.z
	var collision = move_and_collide(dir * move_speed * delta)
	
	if move_speed == 0:
		destroy_timer.stop()
		
	if collision:
		if damage > 0:
			if collision.get_collider().has_method("take_damage"):
				collision.get_collider().take_damage(damage)
		queue_free()

func _destroy_timeout() -> void:
	queue_free()
