extends Node2D

@onready var tilemap := $TileMap
@onready var player := $Player
@onready var king := $King
@onready var trap_selector := $TrapSelector

const FLOOR_COORDINATE := 10
const SPIKE_COORDINATE := 11

var _removed_tiles: PackedVector2Array

func _ready() -> void:
	king.spawn_behind_player.connect(add_trap_behind_player)
	king.spawn_ahead_player.connect(add_trap_ahead_player)


func spawn_trap(_pos: Vector2, _dir: int = 1) -> void:
	var _target_position := _pos
	
	if not trap_selector.current_trap.floating:
		_target_position.y = FLOOR_COORDINATE
	
	if trap_selector.current_trap.custom_y:
		_target_position.y = trap_selector.current_trap.custom_y
	
	if trap_selector.current_trap.scene:
		var _ns: Node2D = trap_selector.current_trap.scene.instantiate()
		_ns.global_position = tilemap.map_to_local(_target_position)
		
		if trap_selector.current_trap.kind == Trap.Kind.MOVABLE:
			_ns.direction = _dir
			
			if _dir > 0:
				_ns.global_position.x = 0
			elif _dir < 0:
				_ns.global_position.x = get_viewport_rect().size.x
	
		
		add_child(_ns)
	
	if trap_selector.current_trap.kind == Trap.Kind.SPIKE:
		var _additional_offset := Vector2.RIGHT if _pos.x > tilemap.local_to_map(player.global_position).x else Vector2.ZERO
		_target_position = Vector2i(_pos.x + _additional_offset.x, SPIKE_COORDINATE)
		
		for spike in get_tree().get_nodes_in_group("spike"):
			if _target_position == spike.global_position.round().snapped(Vector2.ONE * 32) / 32:
				spike.attack()
		

	if trap_selector.current_trap.kind == Trap.Kind.HOLE:
		# Qual tile "secundário" também será removido
		var _additional_offset := Vector2.RIGHT if _pos.x > tilemap.local_to_map(player.global_position).x else Vector2.LEFT
		_target_position = Vector2i(round(_pos.x), FLOOR_COORDINATE)
		tilemap.set_cell(0, _target_position, -1)
		tilemap.set_cell(0, _target_position + _additional_offset, -1)
		tilemap.set_cell(1, _target_position, -1)
		tilemap.set_cell(1, _target_position + _additional_offset, -1)
		
		
		_removed_tiles.append(_target_position)
		_removed_tiles.append(_target_position + _additional_offset)
		
		await get_tree().create_timer(1.2).timeout
		
		for i in range(_removed_tiles.size()):
			var _idx := wrapi(_removed_tiles.size() - 1 - i, 0, _removed_tiles.size())
			tilemap.set_cell(0, _removed_tiles[_idx], 0, Vector2i.ZERO, 1)
			tilemap.set_cell(1, _removed_tiles[_idx], 0, Vector2i.ZERO, 2)
			_removed_tiles.remove_at(_idx)


func add_trap_ahead_player() -> void:
	if trap_selector.is_in_cooldown or not is_instance_valid(player): return
	
	var _target_position: Vector2i = tilemap.local_to_map(player.global_position) + Vector2i.RIGHT
	trap_selector.is_in_cooldown = true
	spawn_trap(_target_position, 1)
	

func add_trap_behind_player() -> void:
	if trap_selector.is_in_cooldown or not is_instance_valid(player): return
	
	var _target_position: Vector2i = tilemap.local_to_map(player.global_position) + Vector2i.LEFT
	trap_selector.is_in_cooldown = true
	
	spawn_trap(_target_position, -1)
