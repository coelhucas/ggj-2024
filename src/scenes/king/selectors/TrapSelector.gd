extends Node2D

@onready var timer := $Timer
@onready var sprite := $Sprite2D

@export_category("Config")
@export var traps: Array[Trap]

var is_in_cooldown := false:
	set(_iic):
		is_in_cooldown = _iic
		
		if is_in_cooldown:
			modulate.a = 0.6
			# TODO: definir cooldown dinâmico invés de fixo hardcoded
			await get_tree().create_timer(0.8).timeout
			is_in_cooldown = false
			modulate.a = 1.0
		
var trap_idx := 0
var current_trap: Trap = null

func _ready() -> void:
	randomize()
	traps.shuffle()
	current_trap = traps[0]
	sprite.texture = traps[trap_idx].icon
	
	timer.timeout.connect(func():
		trap_idx = wrapi(trap_idx + 1, 0, traps.size())
		current_trap = traps[trap_idx]
		sprite.texture = current_trap.icon
	)
