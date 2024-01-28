extends Area2D

signal placed_box

var visible_boxes = 0

func _ready():
	for child in get_children():
		if child != $CollisionShape2D:
			child.visible = false

func _on_body_entered(body):
	if body == %Player:
		if body.box_icon.visible:
			placed_box.emit()
			get_child(visible_boxes).visible = true
			visible_boxes += 1
			if visible_boxes == Global.MAX_BOXES:
				Global.game_over.emit(false)
