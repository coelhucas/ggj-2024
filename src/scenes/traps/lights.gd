extends CanvasModulate

func _ready() -> void:
	Global.lights_on.connect(func():
		hide()
	)
	
	Global.lights_off.connect(func():
		show()
	)
