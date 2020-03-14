extends Node2D

onready var playerposition = $Player.position
onready var score = 0
onready var coin = $Coin
onready var text = $InterfaceLayer/Control/Points
onready var GameManager = get_node("res://assets/Scripts/GameManager.gd")
var currentLevel
var coinpoints = 100
	
func _ready():
	$InterfaceLayer/Control/Points.text = "Bonus Coin Available"
	var dir = Directory.new()
	if !dir.dir_exists("res://Saves"):
		dir.open("res://")
		dir.make_dir("res://Saves")
		
	
func get_playerposition():
	return playerposition
	
func set_playerposition(var amount):
	playerposition += amount
	
func get_score():
	return score

func set_score(var amount):
	score += amount

func get_level():
	return get_tree().get_current_scene().get_filename()

# set the level
func set_level(var levelName):
	# currentLevel must be changed to the new level
	currentLevel = levelName
	get_tree().change_scene(levelName)

var GameData = {
	level="",
	score=0,
	playerposition=0,
}

func save_game_state(var saveName):
	
	# create a file object
	var saveGame = File.new()
	saveGame.open("res://Saves/"+saveName+".sve", File.WRITE)
	
	var data = GameData
	
	# store the data
	data.level = get_level()
	data.score = get_score()
	data.playerposition = get_playerposition()
	
	saveGame.store_line(data.to_json())
	saveGame.close()

func load_game_state(var saveName):
	
	# create a file object
	var loadGame = File.new()
	
	# see if the file actually exists before opening it
	if !loadGame.file_exists("res://Saves/"+saveName+".sve"):
		print ("File not found! Aborting...")
		return
	
	# use an empty dictionary to assign temporary data to
	var currentLine = {}

	# read the data in
	loadGame.open("res://Saves/"+saveName+".sve", File.READ)
	while(!loadGame.eof_reached()):
		
		# use currentLine to parse through the file
		currentLine.parse_json(loadGame.get_line())
		
		# assign the data to the variables
		currentLevel  =  currentLine["level"]
		score = currentLine["score"]
		playerposition = currentLine["playerposition"]
	loadGame.close()
	






func _on_SaveButton_pressed():
	save_game_state("MyGame")
	print("Save Complete")

func _on_LoadButton_pressed():
	load_game_state("MyGame")
	print("Load Complete")


func _on_Coin_body_entered(body):
	coin.queue_free()
	text.queue_free()
