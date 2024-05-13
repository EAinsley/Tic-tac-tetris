extends Control

@onready var score_value: Label = $PanelContainer/MarginContainer/GridContainer/ScoreValue

func _ready() -> void:
	if GameManager.game_board != null:
		_connect_board(GameManager.game_board)
	else:
		GameManager.game_board_changed.connect(_connect_board)

func _connect_board(board: Board) -> void:
	board.score_changed.connect(_on_score_changed)

func _on_score_changed(score: int) -> void:
	score_value.text = str(score)
	
