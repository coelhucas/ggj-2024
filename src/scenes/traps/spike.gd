extends Area2D

@onready var collision_shape := $CollisionShape2D

var _init_y := 0

func _ready() -> void:
	_init_y = position.y
	collision_shape.disabled = true


func attack() -> void:
	var _t := create_tween()
	collision_shape.disabled = false
	_t.tween_property(self, "position:y", position.y - 32, 0.2)
	_t.tween_property(self, "position:y", _init_y, 0.2).set_delay(0.5)
	_t.tween_callback(func():
		collision_shape.disabled = true
	)


func _on_body_entered(body):
	body.take_damage()
