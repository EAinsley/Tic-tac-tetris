class_name Board
extends Node

# Also the level manager
const TIC_TAC_TOE_DIRECTIONS : Array = [
	[Vector2.LEFT, Vector2.RIGHT],
	[Vector2.UP, Vector2.DOWN],
	[Vector2.LEFT + Vector2.UP, Vector2.RIGHT + Vector2.DOWN],
	[Vector2.RIGHT + Vector2.UP, Vector2.LEFT + Vector2.DOWN]
]

signal piecies_erased

@export var grid_number : Vector2  ## 格子的总数

var active_tetormino : Array[Tetromino]

enum GridType  {
	EMPTY, CROSS, CIRCLE, FREEZE
}

var _game_board : Array # Array[Array[GridType]]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_board = self
	_game_board.resize(grid_number.x)
	for i in range(grid_number.x):
		var new_colum : Array = []
		new_colum.resize(grid_number.y)
		for j in range(grid_number.y):
			var new_cell = []
			new_cell.resize(2)
			new_cell[0] = GridType.EMPTY
			new_cell[1] = null
			new_colum[j] = new_cell
		_game_board[i] = new_colum
		print("game board: ", _game_board)


func is_grid_empty(position: Vector2) -> bool:
	if is_out_of_board(position):
		return false
	return get_grid_type(position) == GridType.EMPTY
	
	
func is_out_of_board(position: Vector2) -> bool:
	if position.x >= grid_number.x || position.x < -0.1 || position.y >= grid_number.y || position.y < 0:
		return true
	return false

func on_tetromino_locked(tetormino: Tetromino):
	active_tetormino.append(tetormino)
	var piecies = tetormino.piecies
	for piece in piecies:
		_set_grid(piece)
		print("get piecies: ", piece.grid_index)
	print("after locked")
	_debug_print_game_board()
	while piecies != []:
		await get_tree().create_timer(0.5).timeout
		_erase_blocks(piecies)
		print("after erased")
		_debug_print_game_board()
		await get_tree().create_timer(0.5).timeout
		piecies = _fall_tetrominos()
		print("after fall: ")
		_debug_print_game_board()
	tetormino.freezed.connect(_on_piece_freezed.bind(tetormino))
	piecies_erased.emit()

	
		
	
		
func get_grid_type(pos: Vector2):
	return _game_board[pos.x][pos.y][0]

func set_grid_type(pos: Vector2, type: GridType) -> void:
	_game_board[pos.x][pos.y][0] = type

func get_grid_piece(pos: Vector2):
	return _game_board[pos.x][pos.y][1] 

func get_grid(pos: Vector2):
	return _game_board[pos.x][pos.y]

func on_tetromino_destroyed(tetromimo: Tetromino):
	active_tetormino.erase(tetromimo)

# To erase the blocks using tic-tac-toe
func _erase_blocks(piecies: Array[Piece]):
	var piecies_to_erase : Array[Piece] = []
	var mark_piece_erase : Callable = func(piece: Piece):
		if piece and piece not in piecies_to_erase:
			piecies_to_erase.append(piece)
			
	for piece in piecies:
		for directions in TIC_TAC_TOE_DIRECTIONS:
			var center : Vector2 = piece.grid_index
			var left2 : Vector2 = directions[0] * 2 + center
			var left1 : Vector2 = directions[0] + center
			var right1 : Vector2 = directions[1] + center
			var right2 : Vector2 = directions[1] * 2 + center
			if (
				(_is_grid_same(left2, center) and _is_grid_same(left1, center)) 
				or (_is_grid_same(left1, center) and _is_grid_same(right1, center)) 
				or (_is_grid_same(center, right1) and _is_grid_same(center, right2))
			):
				mark_piece_erase.call(get_grid_piece(center))
				for i in range(2):
					var current_grid = center + directions[i]
					while(_is_grid_same(current_grid, center)):
						var piece_to_erase = get_grid_piece(current_grid)
						mark_piece_erase.call(piece_to_erase)
						current_grid += directions[i]
	# erase the piece		
	for piece : Piece in piecies_to_erase:
		var index = piece.grid_index
		_game_board[index.x][index.y] = [GridType.EMPTY, null]
		piece.destroy()
					
			
func _is_grid_same(left: Vector2, right: Vector2):
	return !is_out_of_board(left) && !is_out_of_board(right) && get_grid_type(left) == get_grid_type(right)
	
func _fall_tetrominos() -> Array[Piece]:
	print("fall termino")
	var piecies_erase : Array[Piece] = []
	for tetromino : Tetromino in active_tetormino:
		for piece in tetromino.piecies:
			_erase_grid(piece.grid_index)
		if tetromino.hard_drop():
			for piece in tetromino.piecies:
				piecies_erase.append(piece)
		for piece in tetromino.piecies:
			_set_grid(piece)
	return piecies_erase
	
func _erase_grid(pos: Vector2):
	_game_board[pos.x][pos.y] = [GridType.EMPTY, null]

func _set_grid(piece: Piece):
	var grid_type = GridType.CROSS if piece.is_cross else GridType.CIRCLE
	_game_board[piece.grid_index.x][piece.grid_index.y] = [grid_type, piece]
	
func _debug_print_game_board():
	for row in _game_board:
		var str = "["
		for col in row:
			str += str(col[0]) + ", "
		str += "]"
		print(str)
		
	
func _on_piece_freezed(tetromino: Tetromino) -> void:
	for piece in tetromino.piecies:
		var index = piece.grid_index
		set_grid_type(index, GridType.FREEZE)
		active_tetormino.erase(tetromino)
		


