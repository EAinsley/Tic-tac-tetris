extends Node

enum Tetromino {
	I, O, T, J, L, S, Z
}


var cells: Dictionary = {
		Tetromino.I: [Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0), Vector2(2, 0)],
		Tetromino.O: [Vector2(0, -1), Vector2(0, 0), Vector2(1, -1), Vector2(1, 0)],
		Tetromino.T: [Vector2(0, -1), Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0)],
		Tetromino.J: [Vector2(-1, -1), Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0)],
		Tetromino.L: [Vector2(1, -1), Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0)],
		Tetromino.S: [Vector2(0, -1), Vector2(1, -1), Vector2(-1, 0), Vector2(0, 0)],
		Tetromino.Z: [Vector2(-1, -1), Vector2(0, -1), Vector2(0, 0), Vector2(0, 1)],
	}
	
	
var tetromino_data: Dictionary = {
	Tetromino.I : load("res://resources/i_piece.tres"),
	Tetromino.O : load("res://resources/o_piece.tres"),
	Tetromino.T : load("res://resources/t_piece.tres"),
	Tetromino.J : load("res://resources/j_piece.tres"),
	Tetromino.L : load("res://resources/l_piece.tres"),
	Tetromino.S : load("res://resources/s_piece.tres"),
	Tetromino.Z : load("res://resources/z_piece.tres"),
}

var clockwise_rotation_transform : Transform2D = Transform2D(-PI/2, Vector2.ZERO)
var counter_clockwise_rotation_transform : Transform2D = Transform2D(-PI/2, Vector2(0, 0))

@export var grid_size : Vector2 = Vector2(48, 48)

