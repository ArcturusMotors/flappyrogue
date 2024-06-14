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
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump 
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		flapanim()

	move_and_slide()
	
	# Rotate the player based on velocity
	var target_rotation = velocity.y * 0.002
	
	#Smooth out the rotation of the bird
	rotation = lerp_angle(rotation, target_rotation, ROTATION_LERP_SPEED)
