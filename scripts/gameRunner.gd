extends Node2D

var rng = RandomNumberGenerator.new()
var player_scene =  preload("res://scenes/playerchar.tscn")
var isdead = false
signal game_restart
@onready var death_timer: Timer = $deathTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Labels/game_over.hide()
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
		$p1hp.text = str($p1.hp)
	else:
		$p1hp.text = "Dead"
		if isdead == false:
			_death($p2)
	if self.has_node("p2"):
		$p2hp.text = str($p2.hp)
	else:
		$p2hp.text = "Dead"
		if isdead == false:
			_death($p1)
	
func _death(player) -> void: 
	isdead = true
	$Labels/game_over.text = "%s Wins!" % player.displayName # This line never needs to change as long as the function call is ordered properly
	$Labels/game_over.show()
	print("Death registered")
	death_timer.start()
	

func _on_death_timer_timeout() -> void:
	print("Timer complete")
	game_restart.emit()
	print("game restart emitted")
	self.queue_free()
