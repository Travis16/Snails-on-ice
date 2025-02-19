extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var colour;
var snail_force = 0;
const rotation_snail_force = 3;
const max_snail_force = 5000
const min_snail_force = 0
var forward_direction = Vector2.RIGHT
var latest_collision
var id
var input_delay = 0.1
var accel = 4000
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
		snail_force = clamp(snail_force + (accel * delta), min_snail_force, max_snail_force)
		velocity = velocity.lerp(forward_direction*snail_force, delta*input_delay)
	elif Input.is_action_pressed("down" + id):
		snail_force = clamp(snail_force - (brake * delta), min_snail_force, max_snail_force)
		velocity = velocity.lerp(forward_direction*snail_force, delta*input_delay)
	else:
		snail_force = min_snail_force
		velocity = velocity.lerp(Vector2(0,0), delta * 0.5)
		
		
	if Input.is_action_pressed("right" + id):
		self.rotation_degrees += rotation_snail_force
	if Input.is_action_pressed("left" + id):
		self.rotation_degrees -= rotation_snail_force
		
		
	
	
	
	
	
	
	var collision_info = move_and_collide(velocity*delta)
