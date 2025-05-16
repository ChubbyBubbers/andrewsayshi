extends Node3D

@export var active = false

@onready var originCam = $"../CharacterBody3D/Camera3D"
@onready var cam1 = $Cam1
@onready var player = $"../CharacterBody3D"
@onready var camObject = $Area3D
@onready var activeCam = $Cam1
@onready var button1 = $"../CharacterBody3D/Camera3D/Control/CamSystemUI/Cam1"
@onready var buttonGroup = button1.button_group
@onready var cameraSystem = $"."

var camStartPos = Vector3.ZERO
var camStartRot = Vector3.ZERO
var camEndPos = Vector3(0.228,-0.606,-0.1)
var camEndRot = Vector3(deg_to_rad(67.7),0,0)

func _ready() -> void:
	for button in buttonGroup.get_buttons():
		if button:
			button.pressed.connect(_on_camera_button_pressed.bind(button))

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true and player.inProcess == false and player.state == 2:
			player.inProcess = true
			player.state = -1
			# animation
			var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
			tween.set_parallel(true)
			tween.tween_property(camObject, "position", camEndPos, .5)
			tween.tween_property(camObject, "rotation", camEndRot, .5)
			await tween.tween_interval(.45).finished
			
			activeCam.current = true
			originCam.current = false
			active = true
			player.inProcess = false

# exit button on the top left of the screen
func _on_exit_button_pressed() -> void:
	player.inProcess = true
	activeCam.current = false
	originCam.current = true
	player.state = 2
	active = false
	# animation
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(camObject, "position", camStartPos, .5)
	tween.tween_property(camObject, "rotation", camStartRot, .5)
	await tween.tween_interval(.45).finished
	player.inProcess = false

# - use a button system where all connect to one func
# - make animation FIRST PLSSSSS


func _on_camera_button_pressed(button):
	activeCam.current = false
	activeCam = cameraSystem.get_children()[buttonGroup.get_buttons().find(button)]
	activeCam.current = true
