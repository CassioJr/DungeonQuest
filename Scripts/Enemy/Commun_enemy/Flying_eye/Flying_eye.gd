extends Area2D


var health = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if health != 0: 
		$AnimatedSprite.play("flying")


func _on_Flying_eye_area_entered(area):
	if area.is_in_group("sword"):
		health -= 50
		$AnimatedSprite.play("taking_hit")
		if health == 0:
			$AnimatedSprite.play("death")


func _on_AnimatedSprite_animation_finished():
	if 	$AnimatedSprite.animation == "death":
		queue_free()
