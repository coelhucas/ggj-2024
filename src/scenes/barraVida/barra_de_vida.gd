extends Node2D

@onready var player_node := %Player

func _ready():
	print(player_node)
	Global.health_update.connect(_on_health_update)
	Global.game_over.connect(_on_health_update)
	
func _on_health_update(_stage):
	remove_child(get_child(player_node.hp + 1))
