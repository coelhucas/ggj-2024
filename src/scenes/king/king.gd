extends Node2D

# TODO: separar animation player em um pra cada mão, para que sejam independentes
@onready var animation_player := $AnimationPlayer
@onready var sfx := $AudioStreamPlayer

signal spawn_enemy
signal spawn_trap

func _physics_process(delta):
	if Input.is_action_just_pressed("p2_left") and not Global.is_in_cooldown:
		animation_player.play("PressRight")
	
	if Input.is_action_just_pressed("p2_right") and not Global.is_in_cooldown:
		animation_player.play("PressLeft")


func spawn_ahead() -> void:
	spawn_trap.emit()
	sfx.pitch_scale = randf_range(0.8, 1.2)
	sfx.play()
	

func spawn_behind() -> void:
	spawn_enemy.emit()
	sfx.pitch_scale = randf_range(0.8, 1.2)
	sfx.play()
