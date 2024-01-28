extends CanvasLayer

@onready var end_game_panel := $EndGame
@onready var btn_restart := $EndGame/BtnRestart
@onready var end_game_bg := $EndGame/Bg

@export var texture_king_win: Texture2D
@export var texture_jester_win: Texture2D

var game_finished := false

func _ready() -> void:
	end_game_panel.hide()
	Global.game_over.connect(display)
	btn_restart.pressed.connect(get_tree().reload_current_scene)


func display(_king_win: bool) -> void:
	if game_finished: return
	
	if not _king_win:
		Global.play_win_sfx()

	end_game_bg.texture = texture_king_win if _king_win else texture_jester_win
	end_game_panel.show()
	game_finished = true
