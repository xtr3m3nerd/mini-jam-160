extends AudioStreamPlayer3D
class_name Footsteps

@export var footstep_streams: Array[AudioStream]

var is_playing = false

func play_steps():
	if !is_playing:
		is_playing = true
		play_step()

func stop_steps():
	is_playing = false

func _on_finished():
	if is_playing:
		play_step()

func play_step():
	stream = footstep_streams.pick_random()
	play()

func on_character_mover_moved(velocity, grounded):
	if !grounded:
		stop_steps()
	else:
		if velocity.length() < 1:
			stop_steps()
		else:
			play_steps()
