extends Node2D

@onready var tilemap := $TileMap
@onready var player := $Player
@onready var king := $King
@onready var trap_selector := $TrapSelector

const FLOOR_COORDINATE := 10

func _ready() -> void:
	king.spawn_behind_player.connect(add_trap_behind_player)
	king.spawn_ahead_player.connect(add_trap_ahead_player)


func add_trap_ahead_player() -> void:
	if trap_selector.is_in_cooldown: return
	
	var _target_position: Vector2i = tilemap.local_to_map(player.global_position) + Vector2i.RIGHT
	trap_selector.is_in_cooldown = true
	
	if not trap_selector.current_trap.floating:
		_target_position.y = FLOOR_COORDINATE
	
	if trap_selector.current_trap.scene:
		var _ns: Node2D = trap_selector.current_trap.scene.instantiate()
		_ns.global_position = tilemap.map_to_local(_target_position)
		
		add_child(_ns)

func add_trap_behind_player() -> void:
	if trap_selector.is_in_cooldown: return
	
	var _target_position: Vector2i = tilemap.local_to_map(player.global_position) + Vector2i.LEFT
	trap_selector.is_in_cooldown = true
	
	if not trap_selector.current_trap.floating:
		_target_position.y = FLOOR_COORDINATE
	
	if trap_selector.current_trap.scene:
		var _ns: Node2D = trap_selector.current_trap.scene.instantiate()
		_ns.global_position = tilemap.map_to_local(_target_position)
		add_child(_ns)
