extends CharacterBody2D

const ELASTICITY = 0.8
var ACCEL = 800;
var BRAKE_FORCE = 600;
var MAX_SPD = 1000;
var DECEL = 200; 
const ROTATION_SPEED = 3;

var rng = RandomNumberGenerator.new()
var colour;
var dir;
var pressed;

var id
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colour = rng.randi_range(0,1)
	if self.id == 1:
		$green.hide() # p1 is green
	if self.id == 2:
		$red.hide() # p2 is red

		
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
	else: # Decceleration
		if speed > 0:
			speed = max(0, speed - (DECEL * delta))
		else:
			speed = min(0, speed + (DECEL * delta))

	if speed > 0:
		speed = max(0, speed - abs(rotation_direction))
	else:
		speed = min(0, speed + abs(rotation_direction))
		
	# Clamp 
	# Compute direction based on rotation
	var forward_direction = Vector2.RIGHT.rotated(rotation)

	if just_collided: # if just collided	
		bounce_lerp += delta # will take one whole second 
		#print("bouncing progress: ", bounce_lerp, " with destination velocity of ", forward_direction*speed)
		velocity = velocity.lerp(forward_direction*speed, bounce_lerp*0.01)
		if bounce_lerp >= BOUNCE_DURATION/0.1: # once finished lerping
			just_collided = false;
			#print("finished colliding")
			bounce_lerp = 0
	else:  # if normal operation
		velocity = forward_direction * speed;

	# ACTUAL MOVING
	var collision_info = move_and_collide(velocity*delta)
	if collision_info: # if there has been a COLLISION
		just_collided = true;
		#print("just collided")
		bounce_lerp = 0; # this will reset bounce_lerp to 0
		velocity = velocity.bounce(collision_info.get_normal()) * ELASTICITY
		
		var collision_body = collision_info.get_collider();
		if("just_collided" in collision_body): # if collided NOT with the wall
			collision_body.just_collided = true
			if ("bounce_lerp" in collision_body): collision_body.bounce_lerp = 0; # if player character
			collision_body.velocity = velocity;
			collision_body.velocity = velocity.bounce(collision_info.get_normal()) * ELASTICITY

		speed = 0
