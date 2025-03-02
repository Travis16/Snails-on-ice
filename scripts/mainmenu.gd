extends Node2D

var gameScene = preload("res://scenes/snailgame.tscn")
var playAgainButtonScene = preload("res://scenes/playAgainButton.tscn")

@export var snail_game = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_delete_old_game()

func _get_snailgame():
	var children = self.get_children()
	print(children)
	if children!= null and len(children) != 0:
		for child in children:
			if "snailgame" in child.name:
				return child
	return null
	
func _start_New_Game() -> void:
	print(str(Time.get_time_string_from_system()) + ": game restart received")
	
	# check if snail game already exists
	snail_game = _get_snailgame()
	if snail_game != null:
		snail_game.queue_free()
		print(str(Time.get_time_string_from_system()) + ": queue_free suceeded")
		snail_game = null
		
	print(str(Time.get_time_string_from_system()) + ": new game attempting")
	var game = gameScene.instantiate()
	game.name = "snailgame"
	print(str(Time.get_time_string_from_system()) + ": game name reset")
	self.add_child(game, true)

	# new snail_game
	if snail_game == null:
		snail_game = _get_snailgame() # get snail game again
	
	print("Connected signal! Start details --")
	print(snail_game)
	print("-- End signal details")

func _delete_old_game() -> void:
	if snail_game != null:
		snail_game.queue_free()
	_start_New_Game()
	


func _on_deathtimer_timeout() -> void:
	
	snail_game = _get_snailgame()
	var playAgainButton = playAgainButtonScene.instantiate()
	playAgainButton.position.x = 823 # middle of screen
	playAgainButton.position.y = 880 # middle of screen
	playAgainButton.show()
	playAgainButton.connect("button_down", _delete_old_game)
	snail_game.get_node("Labels").add_child(playAgainButton)
	print(str(Time.get_time_string_from_system()) + ": Timer complete")
	print(str(Time.get_time_string_from_system()) + ": game restart begun")
	
	#_delete_old_game()
