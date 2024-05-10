class_name Tetromino
extends Node2D

@export var piece_scene: PackedScene  

var piece_data : PieceData :
	set(value):
		piece_data = value
var piecies: Array[Piece]

@onready var timer: Timer = $Timer

func _ready() -> void:

	var tetromino_cells = SharedData.cells[piece_data.tetromino_type]
	for cell : Vector2 in tetromino_cells:
		var piece: Piece = piece_scene.instantiate() as Piece
		add_child(piece)
		piece.position = cell * piece.get_size()
		piecies.append(piece)
	var cross_position: Array = range(4)
	cross_position.shuffle()
	# Set cross & circle
	for i in range(2):
		piecies[cross_position[i]].sprite_2d.texture = piece_data.piece_texture_cross
		piecies[cross_position[i]].is_cross = true
	for i in range(2, 4):
		piecies[cross_position[i]].sprite_2d.texture = piece_data.piece_texture_circle
		piecies[cross_position[i]].is_cross = false
	pass

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
		print("rotate")
		pass
	elif event.is_action_pressed("hard_drop"):
		while move(Vector2.DOWN):
			pass
		print("hard drop")
		pass

func move(direction: Vector2) -> bool:
	var delta_position = calculate_delta_position(direction, position)
	if delta_position != Vector2.ZERO:
		position += delta_position
	return false
	
func calculate_delta_position(direction: Vector2, position: Vector2) -> Vector2:
	# check for collision
	return direction * piecies[0].get_size()
	return Vector2.ZERO
	



func _on_timer_timeout() -> void:
	move(Vector2.DOWN) # Replace with function body.
