extends Control

@onready var credit_label = $CenterContainer/Credit
@onready var animation_player = $AnimationPlayer

@export var show_time = 1.5
@export var hide_time = 0.5

@onready var menu: Menu = get_parent() as Menu

#order follows IGDA Game Crediting Guidelines as close as possible
#if there are corrections to be made, make them
#note that these guidelines don't normally really apply to jams, or even non-paid work usually...
#https://drive.google.com/file/d/1jhs6vG3Qieu4tjJ6ImqhZ21_pMHkDLxM/view
@export var credits: Array[String]

func _ready():
	credit_label.modulate = Color(1,1,1,0)
	
	ShowCredits()

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		menu.change_to_main_menu()
	if Input.is_action_just_pressed("main_action"):
		menu.change_to_main_menu()
	if Input.is_action_just_pressed("ui_accept"):
		menu.change_to_main_menu()

func ShowCredits():
	
	for credit in credits:
		await ShowCredit(credit)
		await get_tree().create_timer(hide_time).timeout
	
	menu.change_to_main_menu()

func ShowCredit(credit):
	credit_label.text = credit
	animation_player.play("fadein")
	await animation_player.animation_finished
	await get_tree().create_timer(show_time).timeout
	animation_player.play("fadeout")
	await animation_player.animation_finished
