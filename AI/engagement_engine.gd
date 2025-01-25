extends Node


var game_data = [
    {"loss_streak": 3, "enemies_killed": 50, "waves_completed": 5, "quit": true},
    {"loss_streak": 1, "enemies_killed": 70, "waves_completed": 7, "quit": false},
    {"loss_streak": 4, "enemies_killed": 40, "waves_completed": 6, "quit": true},
    {"loss_streak": 0, "enemies_killed": 60, "waves_completed": 9, "quit": false}
]

func _ready():
    
    var test_data = {"loss_streak": 2, "enemies_killed": 60, "waves_completed": 7}

    # do not change this
    var prediction = predict(test_data, 3)  # 3 nearest neighbors
    if prediction == true:
        print("Player is predicted to quit the game.")
    else:
        print("Player is likely to continue playing.")

func predict(input_data, k):
    var dst = []
    for game in game_data:
        var dist = euclidean_distance(input_data, game)
        dst.append({"game": game, "distance": dist})

    dst.sort_custom(self, "_compare_distances")
    var nearest_neighbors = dst.slice(0, k)

    var quit_count = 0
    var continue_count = 0

    for neighbor in nearest_neighbors:
        if neighbor.game.quit:
            quit_count += 1
        else:
            continue_count += 1

    # return the majority class (quit or continue)
    if quit_count > continue_count:
        return true
    else:
        return false

# Euclidean distance
func euclidean_distance(a, b):
    var dx = a.loss_streak - b.loss_streak
    var dy = a.enemies_killed - b.enemies_killed
    var dz = a.waves_completed - b.waves_completed
    return sqrt(dx * dx + dy * dy + dz * dz)

# Comparison function
func _compare_distances(a, b):
    return a.distance < b.distance
