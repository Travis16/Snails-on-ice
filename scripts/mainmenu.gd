extends Node2D

var gameScene = preload("res://scenes/snailgame.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_delete_old_game()

func _start_New_Game() -> void:
	print(str(Time.get_time_string_from_system()) + ": game restart received")
		
	if self.has_node("snailgame"):
		$snailgame.game_restart.disconnect(_start_New_Game)
		$snailgame.queue_free()
		print(str(Time.get_time_string_from_system()) + ": queue_free suceeded")
		
	print(str(Time.get_time_string_from_system()) + ": new game attempting")
	var game = gameScene.instantiate()
	game.name = "snailgame"
	print(str(Time.get_time_string_from_system()) + ": game name reset")
	self.add_child(game, true)
	$snailgame.game_restart.connect(_start_New_Game)

func _delete_old_game() -> void:
	if $snailgame != null:
		$snailgame.queue_free()
	_start_New_Game()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
