extends Node2D


@export var scroll_speed = global.scroll_speed
const tile_width: int = 378 # This is based on the image

@onready var ground_tile = preload("res://world/ground.tscn")
@onready var screen_width = get_viewport().size.x

@onready var pipe_spawner = $pipe_spawner

@onready var start_text = $start_text
@onready var start_timer = $start_timer

@onready var player = $player


var ground_tiles: Array = []

func _ready():
	for i in ceil(screen_width / tile_width):
		var ground_tile_instance = ground_tile.instantiate()
		self.add_child(ground_tile_instance)
		ground_tile_instance.position.y = 300
		ground_tile_instance.position.x = i * tile_width
		ground_tiles.append(ground_tile_instance)
	
	# Creates the amount of tiles to fill the screen
	
func _on_start_timer_timeout():
	pipe_spawner.get_node("pipe_timer").start()
	start_text.queue_free()

	
func _process(delta):
	
	# The introduction section, allows the player to start the game themselves
	
	if not global.playing:
		if Input.is_action_just_pressed("jump"):
			global.playing = true
			
			# Start the 3 second countdown for spawning pipes
			start_timer.start()
			
			# start_text.queue_free()
			
			# Give the player a jump boost so you don't plummet to the ground immediately
			player.velocity.y = player.JUMP_VELOCITY
	
	# So the start text doesn't get start at 3
	if start_timer.time_left > 0:
		start_text.text = str(int(start_timer.time_left) + 1) # Countdown shown in label
			
	
	# Moves all tiles left. infinitely
	if not global.dead:
		for ground_tile in ground_tiles:
			ground_tile.position.x -= scroll_speed * delta
			if ground_tile.position.x <= -tile_width:
				ground_tile.position.x += tile_width * ground_tiles.size()
	
	





