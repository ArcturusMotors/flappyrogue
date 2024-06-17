extends Node2D


@export var scroll_speed = global.scroll_speed
const tile_width: int = 378 # This is based on the image

@onready var ground_tile = preload("res://world/ground.tscn")
@onready var screen_width = get_viewport().size.x

var ground_tiles: Array = []

@onready var pipe_spawner = $pipe_spawner

@onready var start_text = $start_text
@onready var start_timer = $start_timer

@onready var player = $player

@onready var background_tile = $background
const bg_width = 144
var bg_scroll_speed = scroll_speed / 10

var bg_tiles: Array = []

@onready var endmenu = $endmenu

var played_once = false

# Ability timers

@onready var hovercooldown = $hovercooldown
@onready var dodgecooldown = $dodgecooldown

# Status spheres

@onready var hover_sphere = $hover_sphere
@onready var dodge_sphere = $dodge_sphere

@onready var dodge_timeout = $player/dodge_timeout
@onready var hover_timeout = $player/hover_timeout

func _ready():
	for i in ceil(screen_width / tile_width):
		var ground_tile_instance = ground_tile.instantiate()
		self.add_child(ground_tile_instance)
		ground_tile_instance.position.y = 300
		ground_tile_instance.position.x = i * tile_width
		ground_tiles.append(ground_tile_instance)
	
	# Creates the amount of tiles to fill the screen
	
	for i in ceil(screen_width / bg_width):
		var bg_tile_instance = background_tile.duplicate() # This isn't a separate scene so we duplicate
		self.add_child(bg_tile_instance)
		bg_tile_instance.position.y = 128
		bg_tile_instance.position.x = i * bg_width
		bg_tile_instance.visible = true
		bg_tiles.append(bg_tile_instance)
	
	# A similar effect for background
	
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
				
	# Same thing for background
	if not global.dead:
		for bg_tile in bg_tiles:
			bg_tile.position.x -= bg_scroll_speed * delta
			if bg_tile.position.x <= -bg_width:
				bg_tile.position.x += bg_width * bg_tiles.size()
	
	if global.dead && not played_once:
		endmenu.visible = true
		endmenu.get_node("AnimationPlayer").play("menu_slam")
		endmenu.get_node("timer_1").start()
		# print("Bug")
		played_once = true
		
	if global.restart == true:
		get_tree().reload_current_scene()
		global.restart = false
		global.playing = false
		global.dead = false
		global.score = 0
		global.can_dodge = true
		global.can_hover = true
		print("Lmao")
		
	# Powerup Inputs
	if Input.is_key_pressed(KEY_Q) and global.can_dodge == true:
		player.dodge()
		dodgecooldown.start()
	if Input.is_key_pressed(KEY_E) and global.can_hover == true:
		player.hover()
		hovercooldown.start()
		
	# Status spheres for dodge and hover
	if global.dodging:
		var time_left = dodge_timeout.time_left
		var status_percent = time_left / global.dodge_time
		
		if status_percent >= 0.75:
			dodge_sphere.texture = load("res://spheres/orange_sphere_1.png")
		elif status_percent >= 0.5:
			dodge_sphere.texture = load("res://spheres/orange_sphere_2.png")
		elif status_percent >= 0.25:
			dodge_sphere.texture = load("res://spheres/orange_sphere_3.png")
		else:
			dodge_sphere.texture = load("res://spheres/orange_sphere_4.png")
	
	else:
		
		if dodgecooldown.is_stopped():
			dodge_sphere.texture = load("res://spheres/orange_sphere_0.png")
		else:
			var time_left = dodgecooldown.time_left
			if time_left >= 7.5:
				dodge_sphere.texture = load("res://spheres/orange_sphere_4.png")
			elif time_left >= 5:
				dodge_sphere.texture = load("res://spheres/orange_sphere_3.png")
			elif time_left >= 2.5:
				dodge_sphere.texture = load("res://spheres/orange_sphere_2.png")
			elif time_left >=0:
				dodge_sphere.texture = load("res://spheres/orange_sphere_1.png")
	
	if global.hovering:
		var time_left = hover_timeout.time_left
		var status_percent = time_left / global.hover_time
		
		if status_percent >= 0.75:
			hover_sphere.texture = load("res://spheres/red_sphere_1.png")
		elif status_percent >= 0.5:
			hover_sphere.texture = load("res://spheres/red_sphere_2.png")
		elif status_percent >= 0.25:
			hover_sphere.texture = load("res://spheres/red_sphere_3.png")
		else:
			hover_sphere.texture = load("res://spheres/red_sphere_4.png")
	
	else:
			
		if hovercooldown.is_stopped():
			hover_sphere.texture = load("res://spheres/red_sphere_0.png")
		else:
			var time_left = hovercooldown.time_left
			var status_percent = (10 - time_left) / 4
			if time_left >= 7.5:
				hover_sphere.texture = load("res://spheres/red_sphere_4.png")
			elif time_left >= 5:
				hover_sphere.texture = load("res://spheres/red_sphere_3.png")
			elif time_left >= 2.5:
				hover_sphere.texture = load("res://spheres/red_sphere_2.png")
			elif time_left >=0:
				hover_sphere.texture = load("res://spheres/red_sphere_1.png")
	
			
# Resets powerups
func _on_dodgetimer_timeout():
	global.can_dodge = true
func _on_hovertimer_timeout():
	global.can_hover = true
