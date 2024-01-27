extends Node

const LOW_VOLUME_DB := -15

@onready var music_1 := $AudioStreamPlayer
@onready var music_2 := $AudioStreamPlayer2
@onready var music_3 := $AudioStreamPlayer3

@onready var current_song := music_1:
	set(_cs):
		var _prev_song := current_song
		var _t := create_tween()
		current_song = _cs
		current_song.play()
		_t.parallel().tween_property(_prev_song, "volume_db", LOW_VOLUME_DB, 2)
		_t.parallel().tween_property(current_song, "volume_db", 0, 3)
		_t.tween_callback(func():
			_prev_song.stop()
		)

func _ready() -> void:
	music_1.volume_db = LOW_VOLUME_DB
	music_2.volume_db = LOW_VOLUME_DB
	music_3.volume_db = LOW_VOLUME_DB
	current_song.volume_db = 0
	current_song.play()
	Global.health_update.connect(music_stage_changed)


func music_stage_changed(_to: int) -> void:
	match _to:
		2:
			current_song = music_2
		3:
			current_song = music_3
