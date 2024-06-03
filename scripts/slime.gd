extends Node2D

const SPEED = 60

var direction = 1

@onready var ray_cast_2dr = $RayCast2DR
@onready var ray_cast_2dl = $RayCast2DL
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Controls the direction the enemy is facing/moving
	if ray_cast_2dr.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_2dl.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
	position.x += direction * SPEED * delta
