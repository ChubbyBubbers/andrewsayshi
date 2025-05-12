extends Area2D

@export var speed = 10000

var active = false
var thing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		thing.velocity += Vector2.from_angle($".".rotation) * speed * delta
		

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		active = true
		thing = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		active = false
		
