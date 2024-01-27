extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D

const GRAVITY := 50
const SPEED := 200
const JUMP_FORCE := -700

var invincibility_time := false

var hp := 3:
	set(_hp):
		hp = _hp
		if hp <= 0:
			# TODO: derrota do player 1
			Global.game_over.emit(true)
			queue_free()


func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	Global.set_player.emit(self)
	$AnimatedSprite2D.play("idle")


func _physics_process(delta):
	var _input := Input.get_axis("p1_left", "p1_right")
	
	velocity.x = _input * SPEED
	velocity.y += GRAVITY
	
	if _input != 0:
		sprite.flip_h = _input < 0
	
	
	if velocity.x != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	
	if Input.is_action_just_pressed("p1_up") and is_on_floor():
		velocity.y = JUMP_FORCE
	
	move_and_slide()

func take_damage(_amount: int = 1) -> void:
	if invincibility_time: return
	hp -= _amount
	flash()


func flash(_times: int = 3) -> void:
	invincibility_time = true
	for i in range(_times):
		hide()
		await get_tree().create_timer(0.12).timeout
		show()
		await get_tree().create_timer(0.12).timeout
	invincibility_time = false


func _on_feet_body_entered(body):
	if velocity.y > 0:
		velocity.y = JUMP_FORCE
		body.queue_free()
