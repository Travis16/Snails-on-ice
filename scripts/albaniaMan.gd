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
	colour = 0 # TODO REMOVE make green
	
	if colour == 0: # green
		$red.hide()
	else:
		$green.hide()

const NPC_DECEL = 500;
func _physics_process(delta: float) -> void:

	if velocity == Vector2(0, 0):
		velocity = Vector2(randf_range(-600, 600), randf_range(-600, 600))
	else:
		velocity -= Vector2(velocity.x/NPC_DECEL, velocity.y/NPC_DECEL)
	if colour == 0:
		rotation_degrees += (velocity.y + velocity.x) /100
	else:
		rotation_degrees -= (velocity.y + velocity.x)/100
		
		'''
	pressed = false;
	
	if Input.is_action_pressed("up1"):
		pressed = true;
		dir = 0
		velocity.y = clamp(velocity.y - (ACCEL_Y * ACCEL * delta), -MAX_SPD, MAX_SPD)

	if Input.is_action_pressed("down1"):
		pressed = true;
		dir = 2
		velocity.y = clamp(velocity.y + (ACCEL_Y * ACCEL * delta), -MAX_SPD, MAX_SPD)

	if Input.is_action_pressed("right1"):
		pressed = true;
		dir = 1
		velocity.x = clamp(velocity.x + (ACCEL_X * ACCEL * delta), -MAX_SPD, MAX_SPD)
	if Input.is_action_pressed("left1"):
		pressed = true;
		dir = 3
		velocity.x = clamp(velocity.x - (ACCEL_X * ACCEL * delta), -MAX_SPD, MAX_SPD)

	
	if not pressed:
		if velocity.x > 0:
			velocity.x = max(0, velocity.x - DECEL*delta)
		if velocity.x < 0:
			velocity.x = min(0, velocity.x + DECEL*delta)
		if velocity.y > 0:
			velocity.y = max(0, velocity.y - DECEL*delta)
		if velocity.y < 0:
			velocity.y = min(0, velocity.y + DECEL*delta)
	'''
	
	# ACTUAL MOVING
	var collision_info = move_and_collide(velocity*delta)
	if collision_info: # if there has been a COLLISION
		
		velocity = velocity.bounce(collision_info.get_normal()) * ELASTICITY
				
		var collision_body = collision_info.get_collider();
		if("MAX_SPD" in collision_body): # if collided NOT with the wall
			collision_body.velocity = velocity.bounce(collision_info.get_normal()) * ELASTICITY

	
