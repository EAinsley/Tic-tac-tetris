class_name Board
extends Node

# Also the level manager


@export var grid_number : Vector2  ## 格子的总数

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
	if position.x >= grid_number.x || position.x < 0 || position.y >= grid_number.y || position.y < 0:
		return false
	return _game_board[position.x][position.y] == GridType.EMPTY
	

func on_tetromino_locked(piecies: Array[Piece]):
	pass
	
		


