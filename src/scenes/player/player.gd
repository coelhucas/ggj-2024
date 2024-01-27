extends CharacterBody2D

const GRAVITY := 50
const SPEED := 400
const JUMP_FORCE := -800

func _physics_process(delta):
	var _input := Input.get_axis("p1_left", "p1_right")
	velocity.x = _input * SPEED
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("p1_up"):
		velocity.y = JUMP_FORCE
	
	move_and_slide()
