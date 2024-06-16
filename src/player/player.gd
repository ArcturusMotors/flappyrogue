extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -300.0
var anim_frame = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Rotation speed factor for smooth rotation
const ROTATION_LERP_SPEED = 0.5

# Cycles through flapping frames
func flapanim():
	var texture = load("res://player/yellowbird-upflap.png")
	$Sprite2D.texture = texture
	await get_tree().create_timer(0.15).timeout
	texture = load("res://player/yellowbird-midflap.png")
	$Sprite2D.texture = texture
	await get_tree().create_timer(0.25).timeout
	texture = load("res://player/yellowbird-downflap.png")
	$Sprite2D.texture = texture


func _physics_process(delta):
	if global.playing and not global.dead:
		# Handle Jump
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			flapanim()

	# Add the gravity.
	velocity.y += gravity * delta

	move_and_slide()

	# Rotate the player based on velocity
	var target_rotation = velocity.y * 0.002

	# Smooth out the rotation of the bird
	rotation = lerp_angle(rotation, target_rotation, ROTATION_LERP_SPEED)
	
	# Lets the player fall off the screen after death
	if global.dead == true:
		get_node("CollisionShape2D").disabled = true

# Dodging Mechanic
func dodge():
	self.modulate.a = 0.5
	get_node("CollisionShape2D").disabled = true
	get_node("DodgeTimer").start()
	

func _on_dodge_timer_timeout():
	self.modulate.a = 1
	get_node("CollisionShape2D").disabled = false
	
#Hover Mechanic
func hover():
	get_node("CollisionShape2D").disabled = true
	self.modulate.a = 0.5
	var interrupt = false
	for i in range(7): # to control how long the powerup lasts for
		velocity.y = JUMP_VELOCITY*0.5
		flapanim()
		await get_tree().create_timer(0.3912).timeout
	get_node("CollisionShape2D").disabled = false
	self.modulate.a = 1
