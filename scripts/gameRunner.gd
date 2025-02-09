extends Node2D


var rng = RandomNumberGenerator.new()
var new_albanian =  preload("res://scenes/albaniaMan.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	spawn_albanians()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_albanians() -> void:
	var newAlbanianInstance = new_albanian.instantiate()
	newAlbanianInstance.position.x = rng.randf_range(0, 1000)
	newAlbanianInstance.position.y = -100
	self.add_child(newAlbanianInstance)
	

func _on_timer_timeout() -> void:
	spawn_albanians()
	$Timer.start()
