class_name Hitbox2D
extends Area2D

var dmg = 1 #again, all damage is just worth 1 point
@export var knockback: int = 1
@export var stun: int = 0

# Called when the node enters the scene tree for the first time.
func _init():
	collision_layer= 4
	collision_mask = 4
	pass # Replace with function body.
