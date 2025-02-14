extends CharacterBody2D

const ELASTICITY = 0.8
var ACCEL = 4000;
var ACCEL_X = 0.2;
var ACCEL_Y = 0.2;
var DECEL = 50; 
var MAX_SPD = 1000;

var rng = RandomNumberGenerator.new()
var xspeed;
var yspeed;
var colour;
var dir;
var pressed;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	xspeed =0;
	yspeed =0;
	
	colour = rng.randi_range(0,1)
	$green.hide() # make pc red
		

	
func _physics_process(delta: float) -> void:
	
	pressed = false;
	
	if Input.is_action_pressed("up"):
		pressed = true;
		dir = 0
		velocity.y = clamp(velocity.y - (ACCEL_Y * ACCEL * delta), -MAX_SPD, MAX_SPD)

	if Input.is_action_pressed("down"):
		pressed = true;
		dir = 2
		velocity.y = clamp(velocity.y + (ACCEL_Y * ACCEL * delta), -MAX_SPD, MAX_SPD)

	if Input.is_action_pressed("right"):
		pressed = true;
		dir = 1
		rotation_degrees += 5
		#velocity.x = clamp(velocity.x + (ACCEL_X * ACCEL * delta), -MAX_SPD, MAX_SPD)
	if Input.is_action_pressed("left"):
		pressed = true;
		dir = 3
		rotation_degrees -= 5
		#velocity.x = clamp(velocity.x - (ACCEL_X * ACCEL * delta), -MAX_SPD, MAX_SPD)

	
	if not pressed:
		if velocity.x > 0:
			velocity.x = max(0, velocity.x - DECEL*delta)
		if velocity.x < 0:
			velocity.x = min(0, velocity.x + DECEL*delta)
		if velocity.y > 0:
			velocity.y = max(0, velocity.y - DECEL*delta)
		if velocity.y < 0:
			velocity.y = min(0, velocity.y + DECEL*delta)
			
	velocity = velocity.rotated(self.rotation)
	velocity = -transform.x * velocity.length()

	# ACTUAL MOVING
	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal()) * ELASTICITY
