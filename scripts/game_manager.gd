extends Node

signal game_board_set(board: Board)

enum GameState {
	END, READYING, PLAYING, PAUSING, LOSING
}

# In game data
var game_board : Board :
	set(board):
		if game_state == GameState.READYING && !game_board:
			game_board = board
			_change_state(GameState.PLAYING)
			game_board_set.emit()

# Game state manage
var game_state : GameState

func _ready() -> void:
	_change_state(GameState.READYING)

func _change_state(new_state: GameState) -> void:
	match game_state:
		_: 
			pass
	match  new_state:
		_:
			pass
	game_state = new_state
	
