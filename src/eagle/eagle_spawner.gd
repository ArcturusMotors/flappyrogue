extends Node2D

@onready var Eagle = preload("res://eagle/moving_eagle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	get_node("grace_period").start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
"""
func _process(delta):
	if global.score == 20:
		get_node("eagle_timer").wait_time(1/(global.score*0.1))
	if global.score == 40:
		get_node("eagle_timer").wait_time(1/(global.score*0.1))
"""
func _on_grace_period_timeout():
	get_node("eagle_timer").start()

func _on_eagle_timer_timeout():
	spawnEagles()

func spawnEagles():
	var eagle = Eagle.instantiate()
	
	add_child(eagle)
	
	eagle.position.y -= randi() % 120
