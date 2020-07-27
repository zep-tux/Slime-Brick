extends CollisionShape2D

func _on_Hit_body_entered(Hit):
	if "Player" in Hit.name:
		Hit.damage(1)
