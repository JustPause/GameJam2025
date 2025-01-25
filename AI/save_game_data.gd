
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
    var file = File.new()
    var data = {}
    
    var filename = "user://games_history.json"

    if file.file_exists(filename):
        file.open(filename, File.READ)
        data = parse_json(file.get_as_text())
        file.close()
    else:
        data = {"games": []}

    data["games"].append(game_data)

    file.open(filename, File.WRITE)
    file.store_string(to_json(data))
    file.close()

func _notification(what):
    if what == NOTIFICATION_WM_QUIT_REQUEST:
        record_game_quit()

func record_game_quit():
    current_game.quit = true
    save_game_data(current_game)
    get_tree().quit()