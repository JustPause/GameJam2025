extends Path2D

class Wave_data:
	var pause_betwene: float
	var units_count: int
	var units: String
	var round: int
		
	func _init(units_count: int, pause_betwene: int, units: String, round:int):
		self.pause_betwene=pause_betwene
		self.units_count = units_count
		self.units = units
		self.round=round

		self.pause_betwene = units_count / pause_betwene

class Enemys:
	var name_enemys: String
	var enemy_type: String
	var max_health: float
	var health: float
	var base_damage: int
	var max_size_growth: Vector2
	var speed: float
	var scene: PackedScene
	
	func _init(name_enemys, enemy_type, max_health, base_damage, max_size_growth, speed, scene):
		self.name_enemys = name_enemys
		self.enemy_type = enemy_type
		self.max_health = max_health
		self.base_damage = base_damage
		self.max_size_growth = max_size_growth
		self.speed = speed

var spawn_time_interval: float

var basic_bubble_scene: PackedScene = preload("res://entities/bubble/basic_bubble/basic_bubble.tscn")
var big_bubble_scene: PackedScene = preload("res://entities/bubble/big_bubble/big_bubble.tscn")
var ice_bubble_scene: PackedScene = preload("res://entities/bubble/ice_bubble/ice_bubble.tscn")

var spawn_enemies: bool = true
var can_spawn: bool = true
var count = 0
var countdown_is_active = false;
var timer_countDown: SceneTreeTimer;

var wave = []
var current_wave_index: int = 0
var wave_timer: Timer
var enemys = [
	Enemys.new("Basic Bubble", "Air", 25.0, 1, Vector2(0.3, 0.3), 400.0, basic_bubble_scene),
	Enemys.new("Basic Bubble1", "Air", 30.0, 1, Vector2(0.6, 0.6), 200.0, basic_bubble_scene),
	Enemys.new("Basic Bubble2", "Air", 5.0, 1, Vector2(0.3, 0.3), 100.0, ice_bubble_scene)
	]

func _ready() -> void:
	wave.append(Wave_data.new(10, 10, "Basic_Bubble",0))

	wave.append(Wave_data.new(3, 2, "Basic_Bubble",1))
	wave.append(Wave_data.new(4, 6, "Advanced_Bubble",1))

	wave.append(Wave_data.new(3, 4, "Advanced_Bubble",2))
	wave.append(Wave_data.new(2, 3, "Ice_Bubble",2))
	wave.append(Wave_data.new(3, 4, "Advanced_Bubble",2))

	wave.append(Wave_data.new(2, 2, "Basic_Bubble",3))
	wave.append(Wave_data.new(2, 3, "Advanced_Bubble",3))
	wave.append(Wave_data.new(3, 2, "Basic_Bubble",3))
	wave.append(Wave_data.new(2, 3, "Ice_Bubble",3))
	wave.append(Wave_data.new(1, 3, "Advanced_Bubble",3))

	wave.append(Wave_data.new(10, 10, "Boss",4))
	
	spawn_time_interval = wave[0].pause_betwene

func spawn_enemy(units) -> void:
	
	print(units)
	var enemy
	if(units=="Basic_Bubble"):
		enemy=basic_bubble_scene.instantiate()
	elif(units=="Advanced_Bubble"):
		enemy=big_bubble_scene.instantiate()
	else:
		enemy=ice_bubble_scene.instantiate()
	
	add_child(enemy)
	
	can_spawn = true

func _physics_process(_delta: float) -> void:
	if spawn_enemies and can_spawn and (wave[current_wave_index].units_count > count):
		# Check if current_wave_index + 1 is within bounds
		if (current_wave_index + 1) < wave.size():
			if wave[current_wave_index + 1] != null and wave[current_wave_index + 1].round == wave[current_wave_index].round and wave[current_wave_index].units_count == count + 1:
				current_wave_index += 1
				count = 0
		
		# Spawn enemy
		spawn_enemy(wave[current_wave_index].units)
		count += 1
		can_spawn = false

		get_tree().create_timer(spawn_time_interval).timeout.connect(_on_spawn_timer_timeout)
	#if self.get_child_count() < wave[current_wave_index].amount_in_a_round:
	
	if self.get_child_count() == 0 and can_spawn and !countdown_is_active:
		on_wave_timer_timeout()
		countdown_is_active = true
	
	if (timer_countDown != null):
		if (timer_countDown.time_left != 0):
			pass
			#print(timer_countDown.time_left)

func _on_spawn_timer_timeout() -> void:
	can_spawn = true

func start_next_wave() -> void:
	if current_wave_index < wave.size():
		print("Starting wave ", current_wave_index + 1)
		count = 0 # Reset enemy spawn count
		spawn_enemies = true # Allow enemy spawning
		countdown_is_active = false
	else:
		print("All waves completed!")
		spawn_enemies = false

func on_wave_timer_timeout() -> void:
	print("Wave ", current_wave_index + 1, " completed!")
	spawn_enemies = false
	
	# Move to the next wave
	current_wave_index += 1
	
	timer_countDown = get_tree().create_timer(2)
	timer_countDown.timeout.connect(start_next_wave)
