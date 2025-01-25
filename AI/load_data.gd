extends Node

var games_data = {}

func _ready():
    load_game_data()

# Function to load the game history data from JSON file
func load_game_data():
    var file = File.new()
    var path = "res://games_history.json"
    
    if file.file_exists(path):
        file.open(path, File.READ)
        
        var json_data = file.get_as_text()
        file.close()

        # Parse the JSON data
        var error = OK
        games_data = JSON.parse(json_data, error)

        if error != OK:
            print("Failed to load game data!")
        else:
            print("Game data loaded successfully!")
            print(games_data)
    else:
        print("Game data file not found!")
