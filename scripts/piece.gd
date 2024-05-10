class_name Piece
extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
var is_cross : bool 
func get_size() -> Vector2:
	return collision_shape_2d.shape.get_rect().size


