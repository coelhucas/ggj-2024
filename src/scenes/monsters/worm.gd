extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D

const SPEED := 400

var direction := 1

func _physics_process(delta):
	sprite.play("run")
	if direction > 0: sprite.flip_h = true
	velocity.x = direction * SPEED
	move_and_slide()


func _on_hitbox_body_entered(body):
	if body == self: return
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
