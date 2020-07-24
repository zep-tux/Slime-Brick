extends KinematicBody2D

var lives = 0

export var SPEED: int; # Скорость
export var GRAVITY: int; # Скорость падения
export var JUMP_POWER: int; # Скорость прыжка

var is_fall = false;
var is_fall_anim = false
const FLOOR = 	Vector2(0, -1)
var velocity = Vector2()

func _process(delta):
	# TODO: Фикс, при сочетании других клавиш не работает прыжок
	if Input.is_action_pressed("ui_right") && !is_fall_anim:
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false	
		if is_on_floor(): # Если мы на земле, можем двигаться как обычно
			$AnimatedSprite.play("walk")
		else: 
			$AnimatedSprite.play("jump")
				
	elif Input.is_action_pressed("ui_left") && !is_fall_anim:
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		if is_on_floor(): # Если мы на земле, можем двигаться как обычно (2)
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("jump")
		
	else: # Если просто стоим, то мы просто стоим =) 
		velocity.x = 0
		if is_on_floor() && !is_fall_anim: 
			$AnimatedSprite.play("idle") 
		
	if !is_on_floor() && velocity.y > JUMP_POWER:
		$AnimatedSprite.play("fall")
		is_fall = true
		
	if velocity.y == 0 && is_fall:
		$AnimatedSprite.play("endFall")
		is_fall_anim = true
		
	if Input.is_action_pressed("ui_up") && is_on_floor() && !is_fall_anim:  # Если прыжок на месте делаем анимацыю прыжка
		velocity.y = -JUMP_POWER
		$AnimatedSprite.play("idleJump") # TODO: Фикс анимации
	
	velocity.y +=  (GRAVITY * delta) # Гравитация каждый фиксированный кадр
	velocity = move_and_slide(velocity, FLOOR) 
	
func add_live():
	lives += 1


func _on_AnimatedSprite_animation_finished():
	if is_fall: 
		is_fall = false
		is_fall_anim = false
	pass # Replace with function body.
