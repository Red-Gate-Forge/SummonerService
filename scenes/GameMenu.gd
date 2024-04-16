extends Node3D


func _input(event):
	if event.is_action_pressed("ritual_end"):
		get_tree().change_scene_to_file("res://scenes/GameWorld.tscn")