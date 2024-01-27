extends Node2D

@onready var timer := $Timer
@onready var sprite := $Sprite2D

@export_category("Config")
@export var traps: Array[Trap]

var current_trap := 0

func _ready() -> void:
	randomize()
	traps.shuffle()
	sprite.texture = traps[current_trap].icon
	
	timer.timeout.connect(func():
		current_trap = wrapi(current_trap + 1, 0, traps.size())
		sprite.texture = traps[current_trap].icon
	)
