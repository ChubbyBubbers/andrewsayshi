extends Node3D

@export var active = false

@onready var button = $ButtonR
@onready var door = $MovingPart

var closePos = Vector3(2.6959, 0.312868, -0.861999)
var openPos = Vector3(2.6959, -1.581, -0.861999)
var red = Color(1, 0, 0)
var green = Color(0, 1, 0)
var inProcess = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door.position = openPos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true and inProcess == false:
			inProcess = true
			var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
			if active == false:
				# turn it on
				tween.tween_property(door, "position", closePos, .2)
				button.material.albedo_color = green
			else:
				# turn it off
				tween.tween_property(door, "position", openPos, .2)
				button.material.albedo_color = red
			# swap state
			active = !active
			await tween.tween_interval(.1).finished
			inProcess = false
