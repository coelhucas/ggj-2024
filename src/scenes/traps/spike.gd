extends Area2D


func _on_body_entered(body):
	print("Dano no player")
	body.take_damage()
