extends Node2D

var rng = RandomNumberGenerator.new()
var player_scene =  preload("res://scenes/playerchar.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player1 = player_scene.instantiate()
	player1.position.x = randf_range(100,1800)
	player1.position.y = randf_range(100,900)
	player1.id = "1"
	player1.name="p1"
	self.add_child(player1)
	
	
	var player2 = player_scene.instantiate()
	player2.position.x = randf_range(100,1800)
	player2.position.y = randf_range(100,900)
	player2.id = "2"
	player2.name="p2"
	self.add_child(player2)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	
	if self.has_node("p1"):
		$p1hp.text = str($p1.hp)
	else:
		$p1hp.text = "Dead"
	if self.has_node("p2"):
		$p2hp.text = str($p2.hp)
	else:
		$p2hp.text = "Dead"
	
