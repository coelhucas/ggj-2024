extends CanvasLayer

@onready var end_game_panel := $EndGame
@onready var end_game_label := $EndGame/PanelContainer/MarginContainer/VBoxContainer/VictoryLabel
@onready var btn_restart := $EndGame/PanelContainer/MarginContainer/VBoxContainer/BtnRestart


func _ready() -> void:
	Global.game_over.connect(display)
	btn_restart.pressed.connect(get_tree().reload_current_scene)


func display(_king_win: bool) -> void:
	print("display game over")
	end_game_label.text = "King wins!" if _king_win else "Jester wins!"
	end_game_panel.show()
