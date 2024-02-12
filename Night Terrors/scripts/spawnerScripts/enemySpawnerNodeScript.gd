class_name EnemySpawner2D 
extends Node2D
@export var myParent: Node2D

func _ready():
	get_parent().addSpawnerReference(self.position)
	pass
