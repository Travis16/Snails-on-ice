extends Node2D

var rng = RandomNumberGenerator.new()
var player_scene =  preload("res://scenes/playerchar.tscn")
var isdead = false
var gui_labels

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	gui_labels = get_node("Labels")
	gui_labels.get_node("game_over").hide()
	var player1 = player_scene.instantiate()
	player1.position.x = randf_range(100,1800)
	player1.position.y = randf_range(100,900)
	player1.id = "1"
	player1.name="p1"
	player1.displayName = "Green Snail"
	self.add_child(player1)
	
	
	var player2 = player_scene.instantiate()
	player2.position.x = randf_range(100,1800)
	player2.position.y = randf_range(100,900)
	player2.id = "2"
	player2.name="p2"
	player2.displayName = "Red Snail"
	self.add_child(player2)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	
	if self.has_node("p1"):
		gui_labels.get_node("p1hp").text = str($p1.hp)
	else:
		gui_labels.get_node("p1hp").text = "Dead"
		if isdead == false:
			_death($p2)
	if self.has_node("p2"):
		gui_labels.get_node("p2hp").text = str($p2.hp)
	else:
		gui_labels.get_node("p2hp").text = "Dead"
		if isdead == false:
			_death($p1)
	
func _death(player) -> void: 
	isdead = true
	gui_labels.get_node("game_over").text = "%s Wins!" % player.displayName # This line never needs to change as long as the function call is ordered properly
	gui_labels.get_node("game_over").show()
	print(str(Time.get_time_string_from_system()) + ": Death registered")
	
	# Changed - because we know it will have a parent (mainmenu).
	get_parent().get_node("deathTimer").start()
	
