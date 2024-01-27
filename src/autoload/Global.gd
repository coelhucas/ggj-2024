extends Node

signal set_player(_p)
signal game_over(_king_win)
signal health_update(_music_stage)
signal lights_on
signal lights_off

var is_in_cooldown := false


func turn_lights_off() -> void:
	lights_off.emit()
	await get_tree().create_timer(10).timeout
	lights_on.emit()
