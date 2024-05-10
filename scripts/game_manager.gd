extends Node


enum GameState {
	End, Readying, Playing, Pausing, Losing
}

# In game data
var game_board : Board :
	set(board):
		if game_state == GameState.Readying && !game_board:
			game_board = board
			_change_state(GameState.Playing)

# Game state manage
var game_state : GameState

func _ready() -> void:
	_change_state(GameState.Readying)

func _change_state(new_state: GameState) -> void:
	match game_state:
		_: 
			pass
	match  new_state:
		_:
			pass
	game_state = new_state
	
