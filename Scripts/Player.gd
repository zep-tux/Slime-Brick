extends KinematicBody2D

export var SPEED: int; # Скорость
export var GRAVITY: int; # Скорость падения
export var JUMP_POWER: int; # Скорость прыжка

const power = 70
var is_fall = false;
var is_anim = false
const FLOOR = 	Vector2(0, -1)
var velocity = Vector2()
var is_damage = false

var HP = 9;

func _process(delta):
	if (HP % 3) == 0 && HP >= 0: $GUI/CanvasLayer/NinePatchRect.texture.set_current_frame(HP / 3)
	if Input.is_action_pressed("ui_right") && !is_anim && !is_damage:
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false	
		if is_on_floor(): # Если мы на земле, можем двигаться как обычно
			$AnimatedSprite.play("walk")
		else: 
			$AnimatedSprite.play("jump")
				
	elif Input.is_action_pressed("ui_left") && !is_anim && !is_damage:
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		if is_on_floor(): # Если мы на земле, можем двигаться как обычно (2)
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("jump")
	
	elif Input.is_action_pressed("ui_end"):
		damage(1)
	
	elif !is_damage: # Если просто стоим, то мы просто стоим =) 
		velocity.x = 0
		if is_on_floor() && !is_anim: 
			$AnimatedSprite.play("idle") 
	
	if is_damage && is_on_floor():
		is_damage = false
	
	if !is_on_floor() && velocity.y > JUMP_POWER:
		$AnimatedSprite.play("fall")
		is_fall = true
		
	if velocity.y == 0 && is_fall:
		$AnimatedSprite.play("endFall")
		is_anim = true
		
	if Input.is_action_pressed("ui_up") && is_on_floor() && !is_anim:  # Если прыжок на месте делаем анимацыю прыжка
		velocity.y = -JUMP_POWER
		$AnimatedSprite.play("idleJump") 
	
	velocity.y +=  (GRAVITY * delta) # Гравитация каждый фиксированный кадр
	velocity = move_and_slide(velocity, FLOOR) 

func _on_AnimatedSprite_animation_finished():
	is_fall = false
	is_anim = false
	pass # Replace with function body.

func damage(var damage: int):
	if !is_damage:
		is_damage = true
		is_anim = true
		if $AnimatedSprite.flip_h:
			velocity.y = -power
			velocity.x = power
		else:
			velocity.y = -power
			velocity.x = -power
		$AnimatedSprite.play("damage")
		HP -= damage
#		if HP <= 0 :
#			 Main.scene('game_over')
#		else:
#			Main.scene(Main.level())

func die():
	$AnimatedSprite.play("Die")
	HP -= 3;
#	if HP <= 0 :
#		Main.scene('game_over')

func _ready(): # Тестирование
	die()
