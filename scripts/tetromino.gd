class_name Tetromino
extends Node2D

signal tetromino_locked(pieces : Array[Piece])

@export var piece_scene: PackedScene  

var piece_data : PieceData :
	set(value):
		piece_data = value
var piecies: Array[Piece]
var spwan_grid: Vector2 :
	set(value):
		current_index = value
		spwan_grid = value
var current_index: Vector2
var board: Board

@onready var timer: Timer = $Timer

func _ready() -> void:
	var tetromino_cells : Array = SharedData.cells[piece_data.tetromino_type]
	for cell : Vector2 in tetromino_cells:
		var piece: Piece = piece_scene.instantiate() as Piece
		add_child(piece)
		piece.self_index = cell
		piece.tetromino = self
		piecies.append(piece)
		piece.tree_exiting.connect(_on_piece_tree_exiting.bind(piece))
	var cross_position: Array = range(4)
	cross_position.shuffle()
	# Set cross & circle
	for i in range(2):
		piecies[cross_position[i]].sprite_2d.texture = piece_data.piece_texture_cross
		piecies[cross_position[i]].is_cross = true
	for i in range(2, 4):
		piecies[cross_position[i]].sprite_2d.texture = piece_data.piece_texture_circle
		piecies[cross_position[i]].is_cross = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		move(Vector2.LEFT)
		print("move left")
	elif event.is_action_pressed("move_right"):
		move(Vector2.RIGHT)
		print("move right")
		pass
	elif event.is_action_pressed("move_down"):
		move(Vector2.DOWN)
		print("move down")
		pass
	elif event.is_action_pressed("rotate"):
		rotate_clockwise()
		print("rotate")
		pass
	elif event.is_action_pressed("hard_drop"):
		while move(Vector2.DOWN):
			pass
		lock()
		print("hard drop")
		pass

func move(direction: Vector2) -> bool:
	var delta_position : Vector2 = calculate_delta_position(direction, position)
	if delta_position == Vector2.ZERO:
		return false
	position += delta_position
	current_index += direction
	return true
	
	
func rotate_clockwise() -> void:
	print("rotate clockwise")
	
	# Calculate rotation origin
	const ROTATE_TRIALS : int = 3
	var offset : Vector2 = Vector2.ZERO
	# Do the rotation
	for i in range(ROTATE_TRIALS):
		var new_index: Array = Array()
		for piece in piecies:
			new_index.append(SharedData.clockwise_rotation_transform * piece.self_index)
		
		# check wall kicks
		var lock_on_success : bool = false
		var left_most: int = board.grid_number.x
		var right_most : int = 0
		var down_most : int = 0
		for index in new_index:
			left_most = min(index.x + current_index.x, left_most)
			right_most = max(index.x + current_index.x, right_most)
			down_most = max(index.y + current_index.y, right_most)
		if left_most < 0:
			offset.x = -left_most
		elif right_most >= board.grid_number.x:
			offset.x = - (right_most - board.grid_number.x + 1)
		if down_most >= board.grid_number.y:
			lock_on_success = true
			offset.y = - (down_most - board.grid_number.y + 1)
		var rotate_success : bool = true
		for index in new_index:
			var index_check = index + current_index + offset
			if !board.is_grid_empty(index_check):
				print("index check: ", index_check, ", offset: ", offset)
				rotate_success = false
				break
		# if there's no space
		if rotate_success:
			for j in range(new_index.size()):
				piecies[j].self_index = new_index[j]
			if lock_on_success:
				lock()
			break
	# update
	move(offset)
		
func calculate_delta_position(direction: Vector2, position: Vector2) -> Vector2:
	# check for collision
	for piece in piecies:
		if board.is_out_of_board(piece.grid_index + direction) || !board.is_grid_empty(piece.grid_index + direction) :
			return Vector2.ZERO
	return direction * piecies[0].get_size()
	
func lock():
	set_process_unhandled_input(false)
	tetromino_locked.emit(self)
	print("locked")
	timer.stop()
	timer.queue_free()

func _on_piece_tree_exiting(piece: Piece) -> void:
	piecies.erase(piece)

func _on_timer_timeout() -> void:
	if !move(Vector2.DOWN):
		lock()
