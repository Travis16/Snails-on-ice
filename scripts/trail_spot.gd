extends Node

var rng = RandomNumberGenerator.new()
var colour

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if colour == 1:
		$slime.modulate.r = rng.randf_range(0, 0.07)
		$slime.modulate.g = rng.randf_range(0.9, 1)
		$slime.modulate.b = 0
	else:
		$slime.modulate.r = rng.randf_range(0.6, 65)
		$slime.modulate.g = 0
		$slime.modulate.b = rng.randf_range(0, 0.07)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$slime.modulate.a -= 0.01
	
	if $slime.modulate.a < 0:
		self.queue_free()
		
		
