extends Node2D

func _ready():
	$CanvasLayer/Restart.connect("pressed",self, "btn_rt")
	$CanvasLayer2/Menu.connect("pressed",self, "btn_mu")
	$CanvasLayer3/Button.connect("pressed", self, "btn_bn")

func btn_rt():
	get_tree().change_scene("res://test_scene.tscn")

func btn_mu():
	get_tree().change_scene("res://Menu.tscn")

func btn_bn():
	get_tree().quit()
