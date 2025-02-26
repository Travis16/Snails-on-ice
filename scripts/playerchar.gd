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
var slistance = 50
var distance_moved = 0
var slime_scene =  preload("res://scenes/trail_spot.tscn")
const max_hp = 5
var hp = max_hp
var invincible = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if id == "1":
		$red.hide()
		$green.set_name("sprite")
	else:
		$green.hide()
		$red.set_name("sprite")
	

func manage_speed(delta: float):
	forward_direction = Vector2.RIGHT.rotated(rotation)
	if Input.is_action_pressed("up" + id):
		snail_force = clamp(snail_force + (accel * delta), min_snail_force, max_snail_force)
		velocity = velocity.lerp(forward_direction*snail_force, delta*input_delay)
	else:
		snail_force = min_snail_force
		velocity = velocity.lerp(Vector2(0,0), delta * 0.5)
		

func manage_direction():
	if Input.is_action_pressed("right" + id):
		self.rotation_degrees += rotation_snail_force
	if Input.is_action_pressed("left" + id):
		self.rotation_degrees -= rotation_snail_force
		
func manage_collision(delta:float):
	var collision_info = move_and_collide(velocity*delta)
	
	if collision_info:
		var what_was_hit = collision_info.get_collider()
		snail_force = 0
		velocity = velocity.bounce(collision_info.get_normal()) * bounce_force
		if "id" in what_was_hit:
			what_was_hit.velocity = velocity.bounce(collision_info.get_normal()) * bounce_force
			
		var collision_force = remap(velocity.length(), 0, 1200, 0.15, 1)
		self.get_parent().get_node("maincam").add_recoil(collision_force)

func spawn_slime():
	var newslime = slime_scene.instantiate()
	newslime.position.x = self.position.x
	newslime.position.y = self.position.y
	if id == "1":
		newslime.colour = 1
	else:
		newslime.colour = 2
	newslime.creator = id
	self.get_parent().add_child(newslime)
	
func check_slime():
	var bodies = $trail_collider.get_overlapping_areas()
	for body in bodies:
		if "creator" in body.get_parent():
			if body.get_parent().creator != id and body.get_parent().get_node("slime").modulate.a > 0.25:
				if invincible == 0:
					hp -= 1
					invincible = 60
					$sprite.modulate.g = 0.1
					$sprite.modulate.b = 0.1
	

	
func _physics_process(delta: float) -> void:
	manage_speed(delta)
		
	manage_direction()
	
	manage_collision(delta)
	
	distance_moved += velocity.length()
	if distance_moved > slistance:
		distance_moved = 0
		spawn_slime()
	
	check_slime()
		
	if invincible > 0:
		invincible -= 1
	else:
		$sprite.modulate.g = 1
		$sprite.modulate.b = 1
		
		
	if hp == 0:
		self.queue_free()
	
	
