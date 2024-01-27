extends Area2D

@export var respawn: Node2D

func _on_body_entered(body):
	body.take_damage()
	body.global_position = respawn.global_position
