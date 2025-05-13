extends Node3D

@onready var originCam = $"../CharacterBody3D/Camera3D"
@onready var cam1 = $Cam1
@onready var player = $"../CharacterBody3D"

@onready var activeCam = $Cam1
var inProcess = false

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true and inProcess == false and player.state == 2:
			inProcess = true
			player.state = -1
			activeCam.current = true
			originCam.current = false
			
			inProcess = false

# exit button on the top left of the screen
func _on_exit_button_pressed() -> void:
	activeCam.current = false
	originCam.current = true
	player.state = 2
