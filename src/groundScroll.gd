extends Node2D


@export var scroll_speed: float = 200.0
const tile_width: int = 378

@onready var ground_tile = preload("res://ground.tscn")
@onready var screen_width = get_viewport().size.x

var ground_tiles: Array = []

func _ready():
	for i in ceil(screen_width / tile_width):
		var ground_tile_instance = ground_tile.instantiate()
		self.add_child(ground_tile_instance)
		ground_tile_instance.position.y = 300
		ground_tile_instance.position.x = i * tile_width
		ground_tiles.append(ground_tile_instance)
	
	
func _process(delta):
	for ground_tile in ground_tiles:
		ground_tile.position.x -= scroll_speed * delta
		if ground_tile.position.x <= -tile_width:
			ground_tile.position.x += tile_width * ground_tiles.size()

