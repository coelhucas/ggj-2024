extends Node2D

@onready var timer := $Timer

func _ready() -> void:
	timer.timeout.connect(func():
		print("change to next trap")
		pass
	)
