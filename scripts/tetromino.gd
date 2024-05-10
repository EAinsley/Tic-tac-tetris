class_name Tetromino
extends Node2D

@export var piece_scene: PackedScene  
var piece_data : PieceData :
	set(value):
		piece_data = value
var piecies: Array[Piece]

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

