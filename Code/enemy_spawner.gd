extends Path2D

class Wave_data:
	var amount_in_a_round: int
	var pause_betwene: float
	var units_count: int
	var units: Array
		
	func _init(amount_in_a_round: int, units_count: int, units: Array):
		self.amount_in_a_round = amount_in_a_round
		self.units_count = units_count
		self.units = units

		self.pause_betwene = units_count / amount_in_a_round

class Enemys:
	var name_enemys: String
	var enemy_type: String
	var max_health: float
	var health: float
	var base_damage: int
	var max_size_growth: Vector2
	var speed: float
	var scene: PackedScene
	
	func _init(name_enemys, enemy_type, max_health, health, base_damage, max_size_growth, speed,scene):
		self.name_enemys = name_enemys
		self.enemy_type = enemy_type
		self.max_health = max_health
		self.health = health
		self.base_damage = base_damage
		self.max_size_growth = max_size_growth
		self.speed = speed

var spawn_time_interval: float

var basic_bubble_scene: PackedScene = preload("res://entities/bubble/basic_bubble/basic_bubble.tscn")
var advanced_bubble_scene: PackedScene = preload("res://entities/bubble/ice_bubble/ice_bubble.tscn")

var spawn_enemies: bool = true
var can_spawn: bool = true
var count = 0

var wave=[]
var enemys = [
	Enemys.new("Basic Bubble", "Air", 5.0, 5.0, 1, Vector2(0.3, 0.3), 300.0,basic_bubble_scene),
	Enemys.new("Basic Bubble1", "Air", 5.0, 5.0, 1, Vector2(0.3, 0.3), 300.0,basic_bubble_scene),
	Enemys.new("Basic Bubble2", "Air", 5.0, 5.0, 1, Vector2(0.3, 0.3), 300.0,basic_bubble_scene),
	Enemys.new("Basic Bubble3", "Air", 5.0, 5.0, 1, Vector2(0.3, 0.3), 300.0,basic_bubble_scene),
	Enemys.new("Basic Bubble4", "Air", 5.0, 5.0, 1, Vector2(0.3, 0.3), 300.0,basic_bubble_scene),
	Enemys.new("Basic Bubble5", "Air", 5.0, 5.0, 1, Vector2(0.3, 0.3), 300.0,basic_bubble_scene)
]

func _ready() -> void:
	wave.append(
		Wave_data.new(5, 10, ["Basic_Bubble"])
		)

	spawn_time_interval = wave[0].pause_betwene

func spawn_enemy() -> void:

	var enemy = basic_bubble_scene.instantiate()

	add_child(enemy)
	can_spawn = true

func _physics_process(_delta: float) -> void:
	if spawn_enemies and can_spawn and (wave[0].amount_in_a_round > count):
		spawn_enemy()
		count += 1
		
		can_spawn = false
		get_tree().create_timer(spawn_time_interval).timeout.connect(_on_spawn_timer_timeout)

func _on_spawn_timer_timeout() -> void:
	can_spawn = true
