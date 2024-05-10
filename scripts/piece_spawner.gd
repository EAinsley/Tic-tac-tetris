# Responsible for control spawning
extends Node

@onready var board: Board = $".."

var current_tetromino: SharedData.Tetromino
@export var tetromino_scene: PackedScene
@export var spawn_position: Vector2 ## 填入格子的位置，左上角为原点


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_tetromino = SharedData.Tetromino.values().pick_random()
	_spwan_tetromino(current_tetromino)

func _spwan_tetromino(type: SharedData.Tetromino, is_preview: bool = false) -> void: 
	var tetromino : Tetromino = tetromino_scene.instantiate() as Tetromino
	tetromino.piece_data = SharedData.tetromino_data[type]
	
	if !is_preview:
		tetromino.position = (spawn_position - board.grid_number / 2  - Vector2.ONE * 0.5) * SharedData.grid_size
		add_child(tetromino)
