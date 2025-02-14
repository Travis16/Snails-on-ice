extends CharacterBody2D

var rng = RandomNumberGenerator.new()
var xspeed;
var yspeed;
var colour;
var dir;
var pressed;

var ACCEL = 2000;
var DECEL = 100;
var MAX_SPD = 2000;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	xspeed =0;
	yspeed =0;
	
	colour = rng.randi_range(0,1)
	if colour == 0:
		$red.hide()
	else:
		$green.hide()

	
func _physics_process(delta: float) -> void:

	if colour == 0:
		rotation_degrees += (velocity.y + velocity.x) /100
	else:
		rotation_degrees -= (velocity.y + velocity.x)/100
		
	
	pressed = false;
	if Input.is_action_pressed("up"):
		pressed = true;
		dir = 0
		velocity.y = clamp(velocity.y - (0.2 * ACCEL * delta), -MAX_SPD, MAX_SPD)

	if Input.is_action_pressed("down"):
		pressed = true;
		dir = 2
		velocity.y = clamp(velocity.y + (0.2 * ACCEL * delta), -MAX_SPD, MAX_SPD)

	if Input.is_action_pressed("right"):
		pressed = true;
		dir = 1
		velocity.x = clamp(velocity.x + (0.2 * ACCEL * delta), -MAX_SPD, MAX_SPD)
	if Input.is_action_pressed("left"):
		pressed = true;
		dir = 3
		velocity.x = clamp(velocity.x - (0.2 * ACCEL * delta), -MAX_SPD, MAX_SPD)

	
	if not pressed:
		if velocity.x > 0:
			velocity.x = max(0, velocity.x - DECEL*delta)
		if velocity.x < 0:
			velocity.x = min(0, velocity.x + DECEL*delta)
		if velocity.y > 0:
			velocity.y = max(0, velocity.y - DECEL*delta)
		if velocity.y < 0:
			velocity.y = min(0, velocity.y + DECEL*delta)
			

	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		print("yoo collision")
		velocity = velocity.bounce(collision_info.get_normal()) * 0.9
	
	
