extends Label

@onready var text_anim = $"../text_anim"
@onready var timer_3 = $"../timer_3"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_2_timeout():
	self.visible = true
	text_anim.play("text_anim_2")
	timer_3.start()
