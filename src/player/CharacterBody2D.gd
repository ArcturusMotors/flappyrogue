extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Rotation speed factor for smooth rotation
const ROTATION_LERP_SPEED = 0.5

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump 
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	move_and_slide()
	
	# Rotate the player based on velocity
	var target_rotation = velocity.y * 0.002
	
	#Smooth out the rotation of the bird
	rotation = lerp_angle(rotation, target_rotation, ROTATION_LERP_SPEED)
