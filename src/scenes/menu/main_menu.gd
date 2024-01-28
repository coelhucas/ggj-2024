extends Node2D


@export var game_scene: PackedScene

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(game_scene)
