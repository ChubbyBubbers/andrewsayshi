extends Node3D

@onready var clock = $ClockBase/Clock
@onready var activeBars = $CharacterBody3D/Camera3D/Control/Container.get_children()
@onready var doorRight = $RightSide/DoorRight
@onready var doorLeft = $LeftSide/DoorLeft
@onready var powerLabel = $CharacterBody3D/Camera3D/Control/Power

var power = 100
var minutes = 0
var minutesText = "";
var hours = 12
var hoursText = "";
var rate = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# check if you win ig
	if hours == 6:
		_win()
	
	# check for power usage
	_update_power_activity()
	_update_power(delta)
	
	# check for power outage
	if power == 0:
		pass
	
	

func _on_second_timeout() -> void:
	# manage time
	minutes += 1
	if minutes >= 60:
		hours += 1
		minutes = 0
		if hours >= 12:
			hours = 1
	# add zeros if needed
	minutesText = str(minutes)
	hoursText = str(hours)
	if minutes < 10:
		minutesText = str(0) + str(minutes)
	if hours < 10:
		hoursText = str(0) + str(hours)
	clock.text = hoursText + ":" + minutesText

func _update_power_activity() -> void:
	var activity = 1
	if doorRight.active == true:
		activity += 1
	if doorLeft.active == true:
		activity += 1
	for i in range(0,4):
		if int(str(activeBars[i].name)) <= activity:
			activeBars[i].visible = true
		else:
			activeBars[i].visible = false
	rate = activity

func _update_power(delta: float) -> void:
	power = power - 1*rate*delta
	power = clamp(power, 0, 100)
	powerLabel.text = "Power: " + str(int(power)) + "%"
	print(power)

func _win() -> void:
	print("you win wowwwwwwwwwwwww")
	#MAKE SURE YOU ACTUALLY PUT SOME STUFF IN HERE AT SOME POINT!
