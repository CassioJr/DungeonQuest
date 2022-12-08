extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 120
const JUMPFORCE = 450
const ACCEL = 15
var input_dir = Vector2()
var isAttacking = false
onready var _animated_sprite = $AnimatedSprite

func _ready():
	_animated_sprite.playing = true
	pass

func _process(delta):
	input_dir.y += GRAVITY 
	if input_dir.y > MAXFALLSPEED:
		input_dir.y = MAXFALLSPEED
		
	input_dir.x = clamp(input_dir.x, -MAXSPEED, MAXSPEED)
	if Input.is_action_pressed("move_right") && isAttacking == false:
		input_dir.x += ACCEL
		_animated_sprite.play("run")
		get_node("AttackArea").set_scale(Vector2(1, 1))
	elif  Input.is_action_pressed("move_left") && isAttacking == false:
		input_dir.x -= ACCEL
		_animated_sprite.play("run")
		get_node("AttackArea").set_scale(Vector2(-1, 1))
	else:
		input_dir.x = lerp(input_dir.x, 0, 0.2)
		if isAttacking == false:
		 _animated_sprite.play("idle")

	if Input.is_action_pressed("move_down") && !Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right") && isAttacking == false:
		_animated_sprite.play("couch")
	if Input.is_action_just_pressed("attack"):
		_animated_sprite.play("attack")
		isAttacking = true
		$AttackArea/AttackCollision.disabled = false		

	if is_on_floor():
		if Input.is_action_just_pressed("move_up") && isAttacking == false:
			 input_dir.y = -JUMPFORCE

	if !is_on_floor():
		if input_dir.y < 0 && isAttacking == false:
			_animated_sprite.play("jump")
		elif input_dir.y > 0 && isAttacking == false:
			_animated_sprite.play("fall")
	
	input_dir = move_and_slide(input_dir, UP)
	
	update_relation(input_dir)

func update_relation(direction):
	_animated_sprite.flip_h = direction.x < 0
	

func _on_AnimatedSprite_animation_finished():
	if _animated_sprite.animation == "attack":
		$AttackArea/AttackCollision.disabled = true
		isAttacking = false
