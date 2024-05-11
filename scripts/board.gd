class_name Board
extends Node

# Also the level manager


@export var grid_number : Vector2  ## 格子的总数
var active_tetormino : Array[Tetromino]

enum GridType  {
	EMPTY, CROSS, CIRCLE
}

var _game_board : Array[Array] # Array[Array[GridType]]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_board = self
	for _i in range(grid_number.x):
		var new_colum : Array[GridType]
		new_colum.resize(grid_number.y)
		_game_board.append(new_colum)


func is_grid_empty(position: Vector2) -> bool:
	if is_out_of_board(position):
		return false
	return _game_board[position.x][position.y] == GridType.EMPTY
	
	
func is_out_of_board(position: Vector2) -> bool:
	if position.x >= grid_number.x || position.x < -0.1 || position.y >= grid_number.y || position.y < 0:
		return true
	return false

func on_tetromino_locked(tetormino: Tetromino):
	active_tetormino.append(tetormino)
	var piecies = tetormino.piecies
	for piece in piecies:
		var grid_type = GridType.CROSS if piece.is_cross else GridType.CIRCLE
		_game_board[piece.grid_index.x][piece.grid_index.y] = grid_type
		print("get piecies: ", piece.grid_index)
		


