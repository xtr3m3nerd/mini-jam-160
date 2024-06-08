class_name GameManager
extends Node

signal level_finished
signal game_win

#@export var victory_screen_prefab: PackedScene
#@export var loading_screen_prefab: PackedScene
#@onready var canvas_layer = $CanvasLayer

var current_level = -1

var kills: int = 0
var loading_screen = null

