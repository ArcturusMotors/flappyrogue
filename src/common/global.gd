extends Node

var scroll_speed: float = 200.0
var score: float = 0.0
var playing: bool = false
var dead: bool = false
var restart: bool = false

var can_dodge = true
var can_hover = true
var hovering = false
var dodging = false
var hover_time = 2
var dodge_time = 2

func _ready():
	pass

func _process(delta):
	pass
