extends Node2D

var gameScene = preload("res://scenes/snailgame.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start_New_Game()

func _start_New_Game() -> void:
	if self.has_node("snailgame"):
		$snailgame.game_restart.disconnect(_start_New_Game)
		$snailgame.queue_free()
		print("queue_free suceeded")
	print("new game attempting")
	var game = gameScene.instantiate()
	game.name = "snailgame"
	print("game name reset")
	self.add_child(game, true)
	$snailgame.game_restart.connect(_start_New_Game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
