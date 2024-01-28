extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D
@onready var light := $Light2D
@onready var box_pile := %BoxPile
@onready var box_stairs := %BoxStairs
@onready var box_icon := $BoxIcon

const GRAVITY := 50
const SPEED := 2000
const JUMP_FORCE := -1200

var invincibility_time := false

var hp := 3:
	set(_hp):
		hp = _hp
		Global.player_damaged()
		
		if hp == 2:
			Global.health_update.emit(2)
		elif hp == 1:
			Global.health_update.emit(3)
		
		if hp <= 0:
			# TODO: derrota do player 1
			Global.game_over.emit(true)
			queue_free()


func _ready() -> void:
	box_stairs.placed_box.connect(_on_placed_box)
	box_pile.took_box.connect(_on_took_box)
	box_icon.visible = false
	
	await get_tree().create_timer(0.1).timeout
	Global.set_player.emit(self)
	Global.lights_off.connect(func():
		light.show()
	)
	Global.lights_on.connect(func():
		light.hide()
	)
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
		Global.play_miss_sfx()
		velocity.y = JUMP_FORCE * 0.8
		body.queue_free()

func _on_placed_box():
	box_icon.visible = false

func _on_took_box():
	box_icon.visible = true
