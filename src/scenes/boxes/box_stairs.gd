extends Area2D

@onready var sfx_drop := $AudioStreamPlayer

signal placed_box

var visible_boxes = 0

func _ready():
	for child in get_children():
		if child != $CollisionShape2D and not child is AudioStreamPlayer:
			child.visible = false

func _on_body_entered(body):
	if body == %Player:
		if body.box_icon.visible:
			sfx_drop.pitch_scale = randf_range(0.8, 1.2)
			sfx_drop.play()
			placed_box.emit()
			get_child(visible_boxes).visible = true
			get_child(visible_boxes + 1).visible = true
			visible_boxes += 2
			if visible_boxes >= Global.MAX_BOXES * 2:
				Global.game_over.emit(false)
