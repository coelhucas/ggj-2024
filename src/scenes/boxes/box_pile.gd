extends Area2D

@onready var sfx_pick := $AudioStreamPlayer

signal took_box

var visible_boxes = Global.MAX_BOXES

func _on_body_entered(body):	
	if body == %Player:
		if not body.box_icon.visible and visible_boxes > 0:
			sfx_pick.pitch_scale = randf_range(0.8, 1.2)
			sfx_pick.play()
			get_child(visible_boxes - 1).visible = false
			visible_boxes -= 1
			took_box.emit()
