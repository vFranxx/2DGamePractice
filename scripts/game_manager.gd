extends Node

var score = 0

@onready var score_label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins!"

func _input(event):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
