extends AudioStreamPlayer3D
class_name RandomAudioStreamPlayer3D

@export var streams: Array[AudioStream]

func _ready():
	stream = streams.pick_random()

func play_random(from_position: float = 0.0):
	stream = streams.pick_random()
	super.play(from_position)
