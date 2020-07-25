extends Node2D

func _ready():
	$CanvasLayer2/Restart.connect('pressed',self, "btn_restart")


func btn_restart():
	get_tree().change_scene("res://test_scene.tscn")
