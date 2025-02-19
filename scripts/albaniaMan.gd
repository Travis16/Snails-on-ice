extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var colour;
var speed = 0;
const rotation_speed = 3;
const max_speed = 1000000
const min_speed = 0
var forward_direction = Vector2.RIGHT
var latest_collision
var id
var input_delay = 0.1
var accel = 800
var brake = 6000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colour = rng.randi_range(0,1)
	if colour == 0:
		$red.hide()
	else:
		$green.hide()

	
func _physics_process(delta: float) -> void:
	forward_direction = Vector2.RIGHT.rotated(rotation)
	
	if Input.is_action_pressed("up" + id):
		speed = clamp(speed + (accel * delta), min_speed, max_speed)
	if Input.is_action_pressed("right" + id):
		self.rotation_degrees += rotation_speed
	if Input.is_action_pressed("down" + id):
		speed = clamp(speed - (brake * delta), min_speed, max_speed)
	if Input.is_action_pressed("left" + id):
		self.rotation_degrees -= rotation_speed
	
	speed = clamp(speed - 0.5, min_speed, max_speed)
	
	latest_collision = move_and_collide(lerp(self.velocity, forward_direction*speed, delta*input_delay)) 
