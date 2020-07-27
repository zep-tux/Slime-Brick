extends CollisionShape2D

var PressIn = false

func _on_Hit_body_entered(Hit):
	
	
	
	if ("Dynamic" in "Hit") == false:
		PressIn = false
	
	if ("Dynamic" in "Hit") == true:
		PressIn = true
	
	if "Player" in Hit.name and PressIn == true:
		Hit.damage(1)
