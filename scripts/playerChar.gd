extends CharacterBody2D

const ELASTICITY = 0.9
var ACCEL = 800;
var BRAKE_FORCE = 600;
var MAX_SPD = 1000;
var DECEL = 200; 
const ROTATION_SPEED = 3;
const INPUT_DELAY = 0.5; # starts at 1, it is an inverse scale factor (ie 0.5 is double delay)

var boost_factor = 1; # this is a factor which will boost enemies that you hit

var rng = RandomNumberGenerator.new()
var colour;
var dir;
var pressed;

var id
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colour = rng.randi_range(0,1)
	if self.id == 1:
		$cyan.hide() # p1 is red
	if self.id == 2:
		$red.hide() # p2 is cyan

		
var speed = 0;
var bouncing = false;
var direction = Vector2.ZERO; # direction vector used later
var just_collided = false;
var bounce_lerp = 0;
var velocity_before_bounce;

const BOUNCE_DURATION = 1 # 1 second

func _physics_process(delta: float) -> void:
	
	# Handle rotation
	var rotation_direction = Input.get_axis("left"+str(id), "right"+str(id));
	rotation_degrees += rotation_direction * ROTATION_SPEED;
	
	# Handle Acceleration and Decceleration
	if Input.is_action_pressed("up"+str(id)):
		# Accelerate 'forwards'
		speed = clamp(speed + (ACCEL * delta), -MAX_SPD, MAX_SPD)
	elif Input.is_action_pressed("down"+str(id)):
		# Brake 'backwards'
		speed = clamp(speed - (BRAKE_FORCE * delta), -MAX_SPD, MAX_SPD)
	else: # Decceleration by nature
		if speed > 0:
			speed = max(0, speed - (DECEL * delta))
		else:
			speed = min(0, speed + (DECEL * delta))

	if Input.is_action_pressed("boost"):
		boost_factor = 3;
	else:
		boost_factor = 1
	# Slight decceleration upon turning
	if speed > 0: 
		speed = max(0, speed - abs(rotation_direction))
	else:
		speed = min(0, speed + abs(rotation_direction))
		
	# Compute direction based on rotation
	var forward_direction = Vector2.RIGHT.rotated(rotation)
	velocity = velocity.lerp(forward_direction*speed, delta*INPUT_DELAY)
	
	# ACTUAL MOVING
	var collision_info = move_and_collide(velocity*delta)
	if collision_info: # if there has been a COLLISION
		velocity = velocity.bounce(collision_info.get_normal()) * ELASTICITY
		speed = 0 # reset speed of bike to 0
		var collision_body = collision_info.get_collider();
		if("MAX_SPD" in collision_body): # if collided NOT with the wall, but another snail
			collision_body.velocity = velocity.bounce(collision_info.get_normal()) * ELASTICITY * boost_factor
