extends KinematicBody2D

export var SPEED: int # Скорость
export var GRAVITY: int; # Скорость падения
export var JUMP_POWER: int; # Скорость прыжка

const FLOOR = 	Vector2(0, -1)
var velocity = Vector2()


var lives = 0


func _process(delta):
	# TODO: Фикс, при сочетании других клавиш не работает прыжок
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false	
		if is_on_floor(): # Если мы на земле, можем двигаться как обычно
			$AnimatedSprite.play("walk")
		else: 
			$AnimatedSprite.play("jump")
			
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		if is_on_floor():# Если мы на земле, можем двигаться как обычно (2)
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("jump")
			
	elif Input.is_action_pressed("ui_up") && is_on_floor(): # Если прыжок на месте делаем анимацыю прыжка
		velocity.y = -JUMP_POWER
		$AnimatedSprite.play("idleJump") # TODO: Фикс анимации
		
	elif is_on_floor() && velocity.y > JUMP_POWER:
		$AnimatedSprite.play("fall")
	
	else: # Если просто стоим, то мы просто стоим =) 
		velocity.x = 0
		if is_on_floor(): 
			$AnimatedSprite.play("idle") 
	
	velocity.y += (GRAVITY * delta) # Гравитация каждый фиксированный кадр
	velocity = move_and_slide(velocity, FLOOR) 

func add_live():
	lives += 1
