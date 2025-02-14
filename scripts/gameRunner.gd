extends Node2D


var rng = RandomNumberGenerator.new()
var new_albanian =  preload("res://scenes/albaniaMan.tscn")
var dir = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	spawn_albanians()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("up"):
		dir = 0
	if Input.is_action_pressed("right"):
		dir = 1
	if Input.is_action_pressed("down"):
		dir = 2
	if Input.is_action_pressed("left"):
		dir = 3
	
func spawn_albanians() -> void:
	var newAlbanianInstance = new_albanian.instantiate()
	if dir == 0:
		newAlbanianInstance.position.x = rng.randf_range(0, 1000)
		newAlbanianInstance.position.y = 1000
	if dir == 1:
		newAlbanianInstance.position.y = rng.randf_range(0, 500)
		newAlbanianInstance.position.x = 100
	if dir == 2:
		newAlbanianInstance.position.x = rng.randf_range(0, 1000)
		newAlbanianInstance.position.y = 100
	if dir == 3:
		newAlbanianInstance.position.y = rng.randf_range(0, 500)
		newAlbanianInstance.position.x = 1400
	
	newAlbanianInstance.dir = dir
	self.add_child(newAlbanianInstance)
	

func _on_timer_timeout() -> void:
	spawn_albanians()
	$Timer.start()
