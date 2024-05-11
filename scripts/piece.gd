class_name Piece
extends Node2D

var is_cross : bool 

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
var tetromino: Tetromino
var self_index: Vector2 :
	set(value):
		_int_x = floor(value.x + 0.5)
		_int_y = floor(value.y + 0.5)
		print("set value: ", value, ", actual set: ", self_index)
		position = self_index * get_size()
	get:
		return Vector2(_int_x, _int_y)
var grid_index: Vector2 :
	get:
		return tetromino.current_index + self_index
var _int_x : int
var _int_y : int

func get_size() -> Vector2:
	return collision_shape_2d.shape.get_rect().size

func move(direction: Vector2) -> void:
	grid_index += direction
	


