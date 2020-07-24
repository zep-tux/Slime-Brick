extends Node2D


func _on_Area2D_body_entered(body):
	if "player" in body.name:
		body.add_live()
		queue_free()
