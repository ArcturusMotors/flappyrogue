extends Label

@onready var text_anim = $"../text_anim"

@onready var timer_2 = $"../timer_2"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_1_timeout():
	self.visible = true
	text_anim.play("text_anim_1")
	timer_2.start()
	


