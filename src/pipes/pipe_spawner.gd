extends Node2D

@onready var Pipe = preload("res://pipes/moving_pipes.tscn")

@onready var pipe_timer = $pipe_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pipe_timer_timeout():
	spawnPipes()
	
	# Spawns pipes
	
func spawnPipes():
	
	var pipe = Pipe.instantiate()
	
	# Create a new pipe
	
	add_child(pipe)
	
	pipe.position.y = 173 # meant to be a bit above the y position of the bottom of the screen
	pipe.position.y -= randi() % 120

