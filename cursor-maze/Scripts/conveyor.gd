extends Area2D

@export var speed = 200

var active = false
var thing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Sprite2D.texture.region.position.x -= speed * delta
	if active:
		var position_change = Vector2.from_angle(self.rotation) * speed * delta
		thing.position.x += position_change.x
		thing.position.y += position_change.y


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		active = true
		thing = body


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		active = false
