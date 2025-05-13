extends Node3D

@export var active = false

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
			# animation
			
			activeCam.current = true
			originCam.current = false
			active = true
			inProcess = false

# exit button on the top left of the screen
func _on_exit_button_pressed() -> void:
	activeCam.current = false
	originCam.current = true
	player.state = 2
	active = false

# use a button system where buttons are togglable and 
# are disabled after clicking them (reenable disabled buttons)
# that way they stay looking selected
