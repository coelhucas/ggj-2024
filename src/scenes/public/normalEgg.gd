extends Node2D

@onready var down := $OvoOlhandoPraBaixo
@onready var left := $OvoOlhandoPraEsquerda
@onready var right := $OvoOlhandoPraDireita
@onready var surprise := $OvoSurpreso
@onready var happy := $OvoFeliz
@onready var cheer := $OvoComemorando

@onready var king := $"../../../King"
@onready var player_node := $"../../../Player"

const AMPL = 5
const SPEED = 100
const FREQ = 3

var offset := Global.TILE_SIZE
var player: Node2D
var looking_at_arena = true
var initial_position: Vector2
var time = 0
var wave_phase: int

func _ready() -> void:
	Global.game_over.connect(_on_game_over)
	king.make_surprise.connect(_on_make_surprise)
	player_node.player_damaged_make_laugh.connect(_on_player_damaged_make_laugh)
	
	initial_position = position
	wave_phase = randi() % AMPL
	
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
		
	time += delta
	position.y = initial_position.y + cos(time * FREQ + wave_phase) * AMPL
	
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
	if not is_instance_valid(player): return
	if player.hp > 0:
		set_visibility(false,false,false,true,false,false)
		lock_expression()

func _on_player_damaged_make_laugh():
	if not is_instance_valid(player): return
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
