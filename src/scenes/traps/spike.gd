extends Area2D

@onready var collision_shape := $CollisionShape2D
@onready var sfx := $AudioStreamPlayer

var _init_y := 0
var damaged_player := false

func _ready() -> void:
	_init_y = position.y
	collision_shape.disabled = true


func attack() -> void:
	sfx.pitch_scale = randf_range(0.8, 1.2)
	sfx.play()
	var _t := create_tween()
	collision_shape.disabled = false
	_t.tween_property(self, "position:y", position.y - Global.TILE_SIZE, 0.2)
	_t.tween_callback(func():
		sfx.pitch_scale = randf_range(0.8, 1.2)
		sfx.play()
	)
	_t.tween_property(self, "position:y", _init_y, 0.2).set_delay(0.5)
	_t.tween_callback(func():
		collision_shape.disabled = true
		
		if not damaged_player:
			Global.play_miss_sfx()
		
		damaged_player = false
	)


func _on_body_entered(body):
	body.take_damage()
	damaged_player = true
