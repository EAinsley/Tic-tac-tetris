class_name PieceSpawner
extends Node
## Responsible for control spawning

signal piece_spawned

const SPEED_UNIT: float = 1000
@export var initial_speed : float = 1000 ## Start speed, 1000 means fall ever 1s
@export var speed_step : float = 50
@export var tetromino_scene: PackedScene
@export var spawn_position: Vector2 ## 填入格子的位置，左上角为原点

var current_tetromino: SharedData.Tetromino
var _current_speed : float 

@onready var board: Board = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_current_speed = initial_speed
	board.piecies_erased.connect(_on_pieces_erased)
	_spwan_new_tetormino()

func _spwan_tetromino(type: SharedData.Tetromino, is_preview: bool = false) -> void: 
	var tetromino : Tetromino = tetromino_scene.instantiate() as Tetromino
	tetromino.piece_data = SharedData.tetromino_data[type]
	tetromino.board = board
	tetromino.tetromino_locked.connect(board.on_tetromino_locked)
	tetromino.tree_exiting.connect(board.on_tetromino_destroyed.bind(tetromino))
	tetromino.falling_time = SPEED_UNIT / _current_speed
	piece_spawned.connect(tetromino.on_spawner_spawned.bind(self))
	if !is_preview:
		tetromino.position = (spawn_position - board.grid_number / 2  + Vector2.ONE * 0.5) * SharedData.grid_size
		tetromino.spwan_grid = spawn_position
		add_child(tetromino)
		
func _spwan_new_tetormino() -> void:
	print("spawn")
	piece_spawned.emit()
	var current_tetromino = SharedData.Tetromino.values().pick_random()
	_spwan_tetromino(current_tetromino)
	
func _on_pieces_erased() -> void:
	_current_speed += speed_step
	_spwan_new_tetormino()
	
