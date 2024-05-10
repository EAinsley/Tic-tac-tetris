# Also the level manager
class_name Board
extends Node

@export var grid_number : Vector2  ## 格子的总数


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_board = self


