extends Node2D

@onready var sprite := $Sprite2D
@onready var skin := $Skin

var offset := 32
var player: Node2D


func _ready() -> void:
	skin.frame = randi() % skin.hframes
	Global.set_player.connect(func(_p):
		print("wow")
		player = _p
	)


func _process(delta):
	if not is_instance_valid(player):
		return
	
	print(abs(player.global_position.x - global_position.x))
	
	if player.global_position.x > global_position.x and abs(player.global_position.x - global_position.x) > offset:
		sprite.frame = 3
	elif player.global_position.x < global_position.x  and abs(player.global_position.x - global_position.x) > offset:
		sprite.frame = 2
	
	if abs(player.global_position.x - global_position.x) < offset:
		sprite.frame = 0
	
