extends Node

var _lev = "test_scene"
var lives = 3;

func scene(name):
	get_tree().change_scene("res://"+name+".tscn")

func level():
	print(_lev)

