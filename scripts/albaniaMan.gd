extends Node2D


var rng = RandomNumberGenerator.new()
var speed;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = rng.randf_range(0.5, 3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed;

	
func _physics_process(delta: float) -> void:
	pass
