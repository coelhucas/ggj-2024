extends Area2D

signal took_box

var visible_boxes = Global.MAX_BOXES

func _on_body_entered(body):	
	if body == %Player:
		if not body.box_icon.visible:
			get_child(visible_boxes - 1).visible = false
			visible_boxes -= 1
			took_box.emit()
