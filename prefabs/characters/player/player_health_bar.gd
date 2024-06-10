class_name PlayerHealthBar
extends Control

@onready var texture_progress_bar = $TextureProgressBar

func on_health_changed(cur_health, max_health):
	texture_progress_bar.max_value = max_health
	texture_progress_bar.value = cur_health
