extends Node2D

var Pipe = preload("res://pipes/moving_pipes.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	spawnPipes()
	
func spawnPipes():
	
	var pipe = Pipe.instantiate()
	
	add_child(pipe)
	
	pipe.position.y = 173 # meant to be a bit above the y position of the bottom of the screen
	pipe.position.y -= randi() % 120
