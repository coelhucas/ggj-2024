extends Node

const TILE_SIZE := 128
const MAX_BOXES = 3


signal set_player(_p)
signal game_over(_king_win)
signal health_update(_music_stage)
signal lights_on
signal lights_off

var is_in_cooldown := false
var sfx_lights_out := preload("res://assets/sounds/sfx/lights_out.ogg")
var sfx_win := preload("res://assets/sounds/sfx/win.ogg")
var sfx_audience_laugh := preload("res://assets/sounds/sfx/laugh.ogg")
var sfx_miss := preload("res://assets/sounds/sfx/miss.ogg")


func turn_lights_off() -> void:
	var _sound: AudioStreamPlayer = AudioStreamPlayer.new()
	_sound.stream = sfx_lights_out
	_sound.autoplay = true
	_sound.finished.connect(func(): _sound.queue_free())
	_sound.bus = "Sfx"
	AudioServer.set_bus_effect_enabled(0, 0, true)
	add_child(_sound)
	
	lights_off.emit()
	await get_tree().create_timer(5).timeout
	AudioServer.set_bus_effect_enabled(0, 0, false)
	lights_on.emit()


func player_damaged() -> void:
	var _sound: AudioStreamPlayer = AudioStreamPlayer.new()
	_sound.stream = sfx_audience_laugh
	_sound.autoplay = true
	_sound.finished.connect(func(): _sound.queue_free())
	_sound.bus = "Sfx"
	add_child(_sound)


func play_miss_sfx() -> void:
	var _sound: AudioStreamPlayer = AudioStreamPlayer.new()
	_sound.stream = sfx_miss
	_sound.autoplay = true
	_sound.finished.connect(func(): _sound.queue_free())
	_sound.bus = "Sfx"
	add_child(_sound)

func play_win_sfx() -> void:
	var _sound: AudioStreamPlayer = AudioStreamPlayer.new()
	_sound.stream = sfx_win
	_sound.autoplay = true
	_sound.finished.connect(func(): _sound.queue_free())
	_sound.bus = "Sfx"
	add_child(_sound)
