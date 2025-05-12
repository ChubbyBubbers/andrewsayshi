extends CharacterBody2D

@export var friction = 15
@export var acceleration = 50
@export var speed_cap = 1000

@onready var ice = $"../Map_HitBoxes/Ice"

var target = position
var direction = self.position.direction_to(target)
var active_friction = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ice.in_ice.connect(_on_in_ice)

# Called when the player enters or leaves ice
# Stops calculation on the speed cap and friction
func _on_in_ice(boolean: bool) -> void:
	if boolean:
		active_friction = false
	else:
		active_friction = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# accelerate the player
	if Input.is_action_pressed("right_click"):
		target = get_global_mouse_position()
		direction = self.position.direction_to(target)
		# add velocity
		self.velocity += direction * acceleration
	# catch friction
	elif active_friction and self.velocity != Vector2.ZERO:
		self.velocity -= self.velocity / friction
	# speed cap
	if active_friction and Vector2(velocity.x, velocity.y).length() > speed_cap:
		var temp = Vector2(velocity.x, velocity.y).normalized() * (speed_cap-1)
		velocity.x = temp.x
		velocity.y = temp.y
	move_and_slide()
