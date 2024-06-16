extends Button

@onready var button_anim = $button_anim

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_1_timeout():
	self.visible = true
	button_anim.play("button_anim")
