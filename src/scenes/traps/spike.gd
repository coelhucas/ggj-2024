extends Area2D

@onready var collision_shape := $CollisionShape2D
@onready var sprite := $Sprite2D
@onready var sfx := $AudioStreamPlayer

var _init_y := 0
var damaged_player := false

func _ready() -> void:
	_init_y = position.y
	collision_shape.disabled = true
	sprite.hide()


func attack() -> void:
	sfx.pitch_scale = randf_range(0.8, 1.2)
	sfx.play()
	var _t := create_tween()
	collision_shape.disabled = false
	sprite.show()
	await get_tree().create_timer(0.2).timeout
	sprite.hide()
	sfx.pitch_scale = randf_range(0.8, 1.2)
	sfx.play()
	collision_shape.disabled = true
		
	if not damaged_player:
		Global.play_miss_sfx()
		
	damaged_player = false


func _on_body_entered(body):
	body.take_damage()
	damaged_player = true
