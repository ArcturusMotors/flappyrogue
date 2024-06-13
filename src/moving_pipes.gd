extends Node2D

var scroll_speed = global.scroll_speed

func _ready():
	pass 

func _process(delta):
	position.x += -scroll_speed*delta
	if position.x <= -600:
		queue_free()

func _on_pipe_body_entered(body):
	if body is Player:
		print("death function goes here")

func _on_score_area_body_exited(body):
	if body is Player:
		print("increase score here")
