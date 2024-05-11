extends Node
## Responsible for control spawning


@export var tetromino_scene: PackedScene
@export var spawn_position: Vector2 ## 填入格子的位置，左上角为原点

var current_tetromino: SharedData.Tetromino

@onready var board: Board = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spwan_new_tetormino()

func _spwan_tetromino(type: SharedData.Tetromino, is_preview: bool = false) -> void: 
	var tetromino : Tetromino = tetromino_scene.instantiate() as Tetromino
	tetromino.piece_data = SharedData.tetromino_data[type]
	tetromino.board = board
	tetromino.tetromino_locked.connect(board.on_tetromino_locked)
	tetromino.tetromino_locked.connect(on_tetromino_locked)
	if !is_preview:
		tetromino.position = (spawn_position - board.grid_number / 2  + Vector2.ONE * 0.5) * SharedData.grid_size
		tetromino.spwan_grid = spawn_position
		add_child(tetromino)
		
func _spwan_new_tetormino() -> void:
	print("spawn")
	var current_tetromino = SharedData.Tetromino.values().pick_random()
	_spwan_tetromino(current_tetromino)
	
func on_tetromino_locked(tetromino: Tetromino) -> void:
	_spwan_new_tetormino()
	
