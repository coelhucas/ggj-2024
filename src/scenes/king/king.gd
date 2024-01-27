extends Node2D

signal spawn_behind_player
signal spawn_ahead_player

func _physics_process(delta):
	if Input.is_action_just_pressed("p2_left"):
		spawn_behind_player.emit()
	
	if Input.is_action_just_pressed("p2_right"):
		spawn_ahead_player.emit()
