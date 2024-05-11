class_name Piece
extends Node2D

var is_cross : bool 

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

var grid_index: Vector2

func get_size() -> Vector2:
	return collision_shape_2d.shape.get_rect().size

func move(direction: Vector2) -> void:
	grid_index += direction


