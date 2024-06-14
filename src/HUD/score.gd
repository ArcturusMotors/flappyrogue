extends Label

var score = global.score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = str(global.score)
	self.set_scale(Vector2(2, 2))  # Scale the label up (e.g., by 2 times)
