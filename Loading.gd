extends Control

func _ready():
	print("loading level from loading scene")
	
func _on_Timer_timeout():
	get_tree().change_scene("res://Level.tscn")
