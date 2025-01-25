
#TODO: make this global
var current_game = {
	"game_id": "1",  # This will be dynamically generated
	"duration": 0,
	"win": false,
	"loss_streak": 0,
	"enemies_killed": 0,
	"waves_completed": 0,
	"quit": false
}

func end_game(win, duration, loss_streak, enemies_killed, waves_completed):
	current_game.win = win
	current_game.duration = duration
	current_game.loss_streak = loss_streak
	current_game.enemies_killed = enemies_killed
	current_game.waves_completed = waves_completed
	current_game.quit = false  # The player didn’t quit
	save_game_data(current_game)


func save_game_data(game_data):
	var path = "res://AI/games_history.json"
	var file = FileAccess.open(path, FileAccess.READ)

	var json_data = file.get_as_text()
	file.close()

	var error = OK
	var json = JSON.new()

	var data = json.parse(json_data, error)
	data["games"].append(game_data)

	var file1 = FileAccess.open(path, FileAccess.WRITE)
	file1.store_string(JSON.stringify(data))
	file1.close()

func _notification(what):
	
	#TODO: find change true to NOTIFICATION_WM_QUIT_REQUEST analogue
	if what == true:
		record_game_quit()

func record_game_quit():
	current_game.quit = true
	save_game_data(current_game)
	#get_tree().quit()
	#TODO: change to working one
