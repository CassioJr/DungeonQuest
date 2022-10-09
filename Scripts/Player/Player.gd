extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 300
const ACCEL = 15

onready var _animated_sprite = $AnimatedSprite

var input_dir = Vector2()
func _ready():
	_animated_sprite.playing = true
	pass

func _physics_process(delta):
	input_dir.y += GRAVITY 
	if input_dir.y > MAXFALLSPEED:
		input_dir.y = MAXFALLSPEED
		
	input_dir.x = clamp(input_dir.x, -MAXSPEED, MAXSPEED)
	if Input.is_action_pressed("move_right"):
		input_dir.x += ACCEL
		_animated_sprite.play("run")
	elif  Input.is_action_pressed("move_left"):
		input_dir.x -= ACCEL
		_animated_sprite.play("run")
	else:
		input_dir.x = lerp(input_dir.x, 0, 0.2)
		_animated_sprite.play("idle")

	if Input.is_action_pressed("move_down") && !Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right"):
		_animated_sprite.play("couch")
	if Input.is_action_just_pressed("attack"):
		_animated_sprite.play("attack")
	
	if is_on_floor():
		if Input.is_action_just_pressed("move_up"):
			 input_dir.y = -JUMPFORCE
	
	if !is_on_floor():
		if input_dir.y < 0:
			_animated_sprite.play("jump")		
		elif input_dir.y>0:
			_animated_sprite.play("fall")		
	
	input_dir = move_and_slide(input_dir, UP)
	
	update_relation(input_dir)
	
func update_relation(direction):
	_animated_sprite.flip_h = direction.x < 0
