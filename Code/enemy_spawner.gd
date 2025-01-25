extends Path2D

class wave_data:
	var amount_in_a_round: int
	var pause_betwene: float
	var units_count: int
	var units: Array
		
	func _init(amount_in_a_round: int, units_count: int, units: Array):
		self.amount_in_a_round = amount_in_a_round
		self.units_count = units_count
		self.units = units

		self.pause_betwene = units_count / amount_in_a_round

class enemys:
	var name_enemys: String
	var max_health: int
	var health: float
	var base_damage: int
	var max_size_growth: Vector2
	var speed: float
	
	func _init(name_enemys, max_health, health, base_damage, max_size_growth, speed):
		self.name_enemys = name_enemys
		self.max_health = max_health
		self.health = health
		self.base_damage = base_damage
		self.max_size_growth = max_size_growth
		self.speed = speed


var spawn_time_interval: float

var basic_bubble: PackedScene = preload("res://entities/bubble/basic_bubble.tscn")

var spawn_enemies: bool = true
var can_spawn: bool = true
var count = 0

var wave=[]
var Basic_Bubble = enemys.new("Basic Bubble", 5, 5.0, 1, Vector2(0.3, 0.3), 300.0)

func _ready() -> void:
	wave.append(
		wave_data.new(5, 10, ["Basic_Bubble"])
		)

	spawn_time_interval = wave[0].pause_betwene

func spawn_enemy() -> void:
	# if not can_spawn:
	# 	return

	var enemy = basic_bubble.instantiate()
	
	# if enemy.has_method("initialize"):
	# 	enemy.call("initialize", Basic_Bubble)

	add_child(enemy)
	can_spawn = true

# func wave_setup() -> void:
# 	for i in range(5):
# 		spawn_enemy()

func _physics_process(_delta: float) -> void:
	if spawn_enemies and can_spawn and (wave[0].amount_in_a_round > count):
		spawn_enemy()
		count += 1
		
		can_spawn = false
		get_tree().create_timer(spawn_time_interval).timeout.connect(_on_spawn_timer_timeout)

func _on_spawn_timer_timeout() -> void:
	# Allow spawning again after the timer expires
	can_spawn = true
