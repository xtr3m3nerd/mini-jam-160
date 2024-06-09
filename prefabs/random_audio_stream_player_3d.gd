extends AudioStreamPlayer3D
class_name RandomAudioStreamPlayer3D

@export var streams: Array[AudioStream]

@export var pitch_min = 0.88
@export var pitch_max = 1.11

func _ready():
	stream = streams.pick_random()

func play_random(from_position: float = 0.0):
	stream = streams.pick_random()
	pitch_scale = randf_range(pitch_min, pitch_max)
	super.play(from_position)
