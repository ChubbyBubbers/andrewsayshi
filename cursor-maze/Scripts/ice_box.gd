extends Area2D

signal in_ice(boolean: bool)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("in_ice", true)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("in_ice", false)
