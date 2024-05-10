extends Node


enum Tetromino {
	I, O, T, J, L, S, Z
}
enum GameState {
	End, Playing, Pausing, Losing
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
	
	
