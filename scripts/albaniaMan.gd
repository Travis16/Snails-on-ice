extends Node2D

var rng = RandomNumberGenerator.new()
var xspeed;
var yspeed;
var colour;
var dir;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	xspeed = 0
	yspeed = 0
	colour = rng.randi_range(0,1)
	if colour == 0:
		$red.hide()
	else:
		$green.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	position.y += yspeed;
	position.x += xspeed;
	rotation_degrees += xspeed + yspeed
	
	if Input.is_action_pressed("up"):
		dir = 0
		yspeed -= 0.1
	if Input.is_action_pressed("right"):
		dir = 1
		xspeed += 0.1
	if Input.is_action_pressed("down"):
		dir = 2
		yspeed += 0.1
	if Input.is_action_pressed("left"):
		dir = 3
		xspeed -= 0.1
