extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D

const AMPL = 700
const SPEED = 850
const FREQ = 8

var direction := 1
var time = 0

func _physics_process(delta):
	time += delta
	
	sprite.play("run")
	velocity.x = direction * SPEED
	velocity.y = cos(time * FREQ) * AMPL

	if direction == 1:
		sprite.flip_h = true
		
	move_and_slide()


func _on_hitbox_body_entered(body):
	if body == self: return
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
