extends Node2D

#@onready var sprite := $Sprite2D
@onready var skin := $Skin

var offset := 32
var player: Node2D

func _ready() -> void:
	var hFrameIndex = 1 + randi() % ((skin.hframes - 2)/3) * 3
	var vFrameIndex = randi() % skin.vframes
	if vFrameIndex % 4 != 0:
		vFrameIndex += 4 - (vFrameIndex % 4)
	
	skin.frame = vFrameIndex * skin.hframes + hFrameIndex
	Global.set_player.connect(func(_p):
		player = _p
	)


#func _process(delta):
	#if not is_instance_valid(player):
		#return
	#
	#if player.global_position.x > global_position.x and abs(player.global_position.x - global_position.x) > offset:
		#sprite.frame = 3
	#elif player.global_position.x < global_position.x  and abs(player.global_position.x - global_position.x) > offset:
		#sprite.frame = 2
	#
	#if abs(player.global_position.x - global_position.x) < offset:
		#sprite.frame = 0
	
