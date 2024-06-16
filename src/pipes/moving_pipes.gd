extends Node2D

var scroll_speed = global.scroll_speed
var score = global.score

func _ready():
	pass 

func _process(delta):
	
	# So pipes stop moving after death
	
	if not global.dead:
		position.x += -scroll_speed*delta
		if position.x <= -600:
			queue_free()

func _on_pipe_body_entered(body):
	if body is Player:
		global.dead = true
	

func _on_score_area_body_exited(body):
	if body is Player:
		global.score += 1
