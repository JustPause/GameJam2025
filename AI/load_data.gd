extends Node

#TODO: Make this a global variable (a singleton) 
# and make it automatically load each time user launches a game
var games_data = {}

func _ready():
	load_game_data()

# Function to load the game history data from JSON file
func load_game_data():
	var path = "res://AI/games_history.json"
	var file = FileAccess.open(path, FileAccess.READ)
		
	var json_data = file.get_as_text()
	file.close()

	# Parse the JSON data
	var error = OK
	var json = JSON.new()
	games_data = json.parse(json_data, error)

	if error != OK:
		print("Failed to load game data!")
	else:
		print("Game data loaded successfully!")
		print(games_data)
