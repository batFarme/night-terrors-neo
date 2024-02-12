extends Node2D


func run(delta):
	if Input.is_action_just_pressed("startButton"):
		get_tree().change_scene_to_file("res://scenes/prototype_environment.tscn")
