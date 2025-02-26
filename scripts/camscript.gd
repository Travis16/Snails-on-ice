extends Camera2D
var newzoom
var cam_delay = 0.8
var recoil = 0
var recoil_exponent = 2
var decay = 0.8 
var max_roll = 0.1
var max_offset = Vector2(100, 75)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	

func add_recoil(amount: float):
	recoil = min(recoil + amount, 0.5)

func shake():
	var amount = pow(recoil, recoil_exponent)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var p1 = get_parent().get_node("p1")
	var p2 = get_parent().get_node("p2")
	
	
	if p1 != null and p2 != null:
		self.global_position = (p1.global_position + p2.global_position) / 2
	
		var zoom_x = 960/absf(p1.global_position.x-p2.global_position.x)
		var zoom_y = 540/absf(p1.global_position.y-p2.global_position.y)
		
		newzoom = max(min(min(zoom_x, zoom_y), 1.5), 0.4)
		self.zoom = lerp(zoom, Vector2(newzoom, newzoom), delta * 2)
		
	if recoil:
		recoil = max(recoil - decay * delta, 0)
		shake()

	
	
	
	
	
	
	
	
		
	 
