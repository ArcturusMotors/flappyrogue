extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -300.0
var anim_frame = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Rotation speed factor for smooth rotation
const ROTATION_LERP_SPEED = 0.5

@onready var hover_timeout = $hover_timeout
@onready var dodge_timeout = $dodge_timeout

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
			global.hovering = false
			flapanim()
		
		if global.hovering:
			velocity.y = 0
		
		else:

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
	if global.can_dodge == true:
		global.can_dodge = false
		self.modulate.a = 0.5 # Transparency effect
		global.dodging = true
		
		dodge_timeout.wait_time = global.dodge_time
		dodge_timeout.start()

func _on_dodge_timeout_timeout():
	self.modulate.a = 1 # Transparency effect
	global.dodging = false
	
#Hover Mechanic
func hover():
	if global.can_hover == true:
		global.can_hover = false
		
		hover_timeout.wait_time = global.hover_time
		hover_timeout.start()
		global.hovering = true


func _on_hover_timeout_timeout():
	global.hovering = false
