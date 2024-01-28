extends Node2D

@onready var down := $OvoFinoOlhandoPraBaixoBigas
@onready var left := $OvoFinoOlhandoEsquerda
@onready var right := $OvoFinoOlhandoDireita
@onready var surprise := $OvoFinoSurpreso
@onready var happy := $OvoFinoFeliz
@onready var cheer := $OvoFinoComemorandoBigas

@onready var king := $"../../../King"
@onready var player_node := $"../../../Player"

var offset := Global.TILE_SIZE
var player: Node2D
var looking_at_arena = true

func _ready() -> void:
	Global.game_over.connect(_on_game_over)
	king.make_surprise.connect(_on_make_surprise)
	player_node.player_damaged_make_laugh.connect(_on_player_damaged_make_laugh)
	
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
	
	if looking_at_arena:
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


func _on_make_surprise():
	if player.hp > 0:
		set_visibility(false,false,false,true,false,false)
		lock_expression()

func _on_player_damaged_make_laugh():
	if player.hp > 0:
		set_visibility(false,false,false,false,true,false)
		lock_expression()

func _on_game_over(_king_win: bool) -> void:
	looking_at_arena = false
	set_visibility(false,false,false,false,false,true)

func lock_expression(_times: int = 3) -> void:
	looking_at_arena = false
	for i in range(_times):
		await get_tree().create_timer(0.3).timeout
	looking_at_arena = true
