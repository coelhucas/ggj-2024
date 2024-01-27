extends CharacterBody2D

const GRAVITY := 50
const SPEED := 400
const JUMP_FORCE := -600

var hp := 3:
	set(_hp):
		hp = _hp
		if hp <= 0:
			# TODO: condicao de derrota do player 1
			queue_free()

func _physics_process(delta):
	var _input := Input.get_axis("p1_left", "p1_right")
	velocity.x = _input * SPEED
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("p1_up") and is_on_floor():
		velocity.y = JUMP_FORCE
	
	move_and_slide()

func take_damage(_amount: int = 1) -> void:
	print("uh")
	hp -= _amount
