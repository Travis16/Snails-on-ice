extends Node

var rng = RandomNumberGenerator.new()
var colour
var creator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if colour == 1:
		$slime.modulate.r = rng.randf_range(0, 0.06)
		$slime.modulate.g = rng.randf_range(0.7, 0.8)
		$slime.modulate.b = 0
	else:
		$slime.modulate.r = rng.randf_range(0.5, 55)
		$slime.modulate.g = 0
		$slime.modulate.b = rng.randf_range(0, 0.06)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$slime.modulate.a -= 0.01
	self.scale = self.scale * 0.999
		
	if $slime.modulate.a < 0:
		self.queue_free()
		
		
