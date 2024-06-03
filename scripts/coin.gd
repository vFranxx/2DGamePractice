extends Area2D

#This wouldn't work if the Coins and GameManager nodes aren't in the same scene
@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	game_manager.add_point()
	animation_player.play("animation_pick_up")
