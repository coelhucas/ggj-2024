extends Node2D

# TODO: separar animation player em um pra cada mão, para que sejam independentes
@onready var animation_player := $AnimationPlayer

signal spawn_behind_player
signal spawn_ahead_player

func _physics_process(delta):
	if Input.is_action_just_pressed("p2_left"):
		animation_player.play("PressRight")
	
	if Input.is_action_just_pressed("p2_right"):
		animation_player.play("PressLeft")


func spawn_ahead() -> void:
	spawn_ahead_player.emit()
	

func spawn_behind() -> void:
	spawn_behind_player.emit()
