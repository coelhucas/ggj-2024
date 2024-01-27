extends CharacterBody2D

@onready var sprite := $Sprite

const SPEED := 500
const ROT_SPEED := 20
const GRAVITY := 50

var direction := 1

func _physics_process(delta):
	velocity.x = direction * SPEED
	velocity.y += GRAVITY
	sprite.rotation += delta * ROT_SPEED
	move_and_slide()


func _on_hitbox_body_entered(body):
	print("damage player")
	body.take_damage()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
