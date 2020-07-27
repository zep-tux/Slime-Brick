extends CollisionShape2D

func press(Hit):
	if "player" and "Press.Dynamic" in Hit.name:
		Hit.damage(1)
		
 
