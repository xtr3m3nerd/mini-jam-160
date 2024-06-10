class_name StateChase
extends State

signal unseen_timeout

@export var unseen_time = 1.0
@export var jump_angle = 30.0
var unseen_timer: Timer

func _ready():
	unseen_timer = Timer.new()
	unseen_timer.wait_time = unseen_time
	unseen_timer.one_shot = true
	unseen_timer.timeout.connect(emit_unseen_timeout)
	add_child(unseen_timer)

func emit_unseen_timeout():
	unseen_timeout.emit()

func during_physics_process(_delta):
	if not behavior.is_player_seen and unseen_timer.is_stopped():
		unseen_timer.start()
	elif behavior.is_player_seen and not unseen_timer.is_stopped():
		unseen_timer.stop()
	
	var dir = behavior.player.global_position - behavior.unit.global_position
	var dir2 = behavior.player.global_position - behavior.unit.global_position
	dir.y = 0.0
	if rad_to_deg(dir.angle_to(dir2)) > jump_angle:
		behavior.character_mover.jump()
	dir = dir.normalized()
	
	behavior.character_mover.set_move_dir(dir)
	var look_at_pos = behavior.player.global_position
	look_at_pos.y = 0.0
	behavior.unit.look_at(look_at_pos)

func on_state_leave():
	unseen_timer.stop()

func on_state_enter():
	pass
