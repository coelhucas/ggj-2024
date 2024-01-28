extends Node2D

@onready var down := $OvoFinoOlhandoPraBaixoBigas
@onready var left := $OvoFinoOlhandoEsquerda
@onready var right := $OvoFinoOlhandoDireita
@onready var surprise := $OvoFinoSurpreso
@onready var happy := $OvoFinoFeliz
@onready var cheer := $OvoFinoComemorandoBigas

var offset := Global.TILE_SIZE
var player: Node2D

func _ready() -> void:
	down.visible = true
	left.visible = false
	right.visible = false
	surprise.visible = false
	happy.visible = false
	cheer.visible = false

	Global.set_player.connect(func(_p):
		player = _p
	)

func _process(delta):
	if not is_instance_valid(player):
		return
	
	if player.global_position.x > global_position.x and abs(player.global_position.x - global_position.x) > offset:
		set_visibility(false,false,true,false,false,false)
	elif player.global_position.x < global_position.x  and abs(player.global_position.x - global_position.x) > offset:
		set_visibility(false,true,false,false,false,false)
	
	if abs(player.global_position.x - global_position.x) < offset:
		set_visibility(true,false,false,false,false,false)
	

func set_visibility(
	_down: bool,
	_left: bool,
	_right: bool,
	_surprise: bool,
	_happy: bool,
	_cheer: bool
	):
	down.visible = _down
	left.visible = _left
	right.visible = _right
	surprise.visible = _surprise
	happy.visible = _happy
	cheer.visible = _cheer
