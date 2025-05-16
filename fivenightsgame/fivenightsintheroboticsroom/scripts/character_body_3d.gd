extends CharacterBody3D

@onready var character = $"."
@onready var left = $Camera3D/Control/TextureRect
@onready var right = $Camera3D/Control/TextureRect2
@onready var down = $Camera3D/Control/TextureRect3
@onready var camSystemUI = $Camera3D/Control/CamSystemUI

@export var state = 2
@export var inProcess = false
var downTopPos = Vector2(1270, 1000)
var downBotPos = Vector2(1270, 0)

func _ready() -> void:
	pass

func _hide(node) -> void:
	node.process_mode = node.PROCESS_MODE_DISABLED
	node.visible = false

func _unhide(node) -> void:
	node.process_mode = node.PROCESS_MODE_INHERIT
	node.visible = true

func _hideAll() -> void:
	_hide(left)
	_hide(right)
	_hide(down)
	_hide(camSystemUI)

func _unhideAll() -> void:
	_unhide(left)
	_unhide(right)
	_unhide(down)

func _process(delta: float) -> void:
	if inProcess == true:
		_hideAll()
	elif state == -1:
		_hideAll()
		_unhide(camSystemUI)
	elif state == 1:
		_hide(left)
		_unhide(right)
		_hide(down)
	elif state == 2:
		_unhideAll()
		_hide(camSystemUI)
	elif state == 3:
		_unhide(left)
		_hide(right)
		_hide(down)
	elif state == 0:
		_hide(left)
		_hide(right)
		_unhide(down)

# left of screen
func _on_texture_rect_mouse_entered() -> void: 
	if inProcess == false:
		inProcess = true
		var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		if state == 2:
			tween.tween_property(character, "rotation", Vector3(0,deg_to_rad(60),0), .6)
			state = 1
		elif state == 3:
			tween.tween_property(character, "rotation", Vector3(deg_to_rad(-3.5),0,0), .6)
			state = 2
		await tween.tween_interval(.04).finished
		inProcess = false

# right of screen
func _on_texture_rect_2_mouse_entered() -> void:
	if inProcess == false:
		inProcess = true
		var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		if state == 2:
			tween.tween_property(character, "rotation", Vector3(0,deg_to_rad(-60),0), .6)
			state = 3
		elif state == 1:
			tween.tween_property(character, "rotation", Vector3(deg_to_rad(-3.5),0,0), .6)
			state = 2
		await tween.tween_interval(.04).finished
		inProcess = false

# bottom of screen
func _on_texture_rect_3_mouse_entered() -> void:
	if inProcess == false:
		inProcess = true
		var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		tween.set_parallel(true)
		if state == 2:
			tween.tween_property(character, "position", Vector3(0,-.2,0), .4)
			tween.tween_property(character, "rotation", Vector3(0,0,deg_to_rad(15)), .6)
			tween.chain().tween_property(character, "position", Vector3(0,-.2,-1), .4)
			tween.tween_property(character, "rotation", Vector3(0,0,deg_to_rad(-15)), .6)
			tween.chain().tween_property(character, "rotation", Vector3(0,deg_to_rad(180),0), .6)
			state = 0
		elif state == 0:
			tween.chain().tween_property(character, "position", Vector3(0,-.2,0), .4)
			tween.chain().tween_property(character, "rotation", Vector3(0,deg_to_rad(0),0), .6)
			tween.tween_property(character, "rotation", Vector3(0,0,deg_to_rad(-15)), .6)
			tween.chain().tween_property(character, "position", Vector3(0,.4,0), 1)
			tween.tween_property(character, "rotation", Vector3(0,0,0), .6)
			state = 2
		await tween.tween_interval(0.4).finished
		inProcess = false
