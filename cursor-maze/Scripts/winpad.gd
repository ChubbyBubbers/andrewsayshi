extends Area2D

@onready var map = str($"../..".name)
@onready var map_num = int(map[-1])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(map_num)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		map_num += 1
		get_tree().change_scene_to_file("res://Scenes/Maps/map_%s.tscn" % map_num)
