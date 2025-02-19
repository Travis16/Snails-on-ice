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
const input_delay = 0.1
var accel = 4000
const bounce_force = 0.8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if id == "1":
		$red.hide()
	else:
		$green.hide()

	
func _physics_process(delta: float) -> void:
	forward_direction = Vector2.RIGHT.rotated(rotation)
	
	if Input.is_action_pressed("up" + id):
		snail_force = clamp(snail_force + (accel * delta), min_snail_force, max_snail_force)
		velocity = velocity.lerp(forward_direction*snail_force, delta*input_delay)
	else:
		snail_force = min_snail_force
		velocity = velocity.lerp(Vector2(0,0), delta * 0.5)
		
		
	if Input.is_action_pressed("right" + id):
		self.rotation_degrees += rotation_snail_force
	if Input.is_action_pressed("left" + id):
		self.rotation_degrees -= rotation_snail_force
		
	var collision_info = move_and_collide(velocity*delta)
	
	if collision_info:
		snail_force = 0
		velocity = velocity.bounce(collision_info.get_normal()) * bounce_force
		
		var what_was_hit = collision_info.get_collider()
		
		if "id" in what_was_hit:
			what_was_hit.velocity = velocity.bounce(collision_info.get_normal()) * bounce_force
		
	
	
	
	
	
