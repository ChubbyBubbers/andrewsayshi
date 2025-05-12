extends Node2D

var player = preload("res://Scenes/player.tscn")
var player_instance = player.instantiate()

@onready var camera = $Camera2D
@onready var start_position = $Map_HitBoxes/start_position
@onready var map = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# change size of player
	player_instance.scale = Vector2(2.5, 2.5)
	# position player to start
	player_instance.position = start_position.position
	# Add player to map
	map.add_child(player_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera.position = player_instance.position
