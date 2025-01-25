extends Path2D

@export var spawn_time_interval : float = 0.5

var basic_bubble : PackedScene = preload("res://entities/bubble/basic_bubble.tscn")

var spawn_enemies : bool = true
var can_spawn : bool = true

class wave_data:
	var amount_in_a_round: int
	var Pause_betwene: int
	var units: String
	
	func _init(amount_in_a_round, Pause_betwene, units):
		self.amount_in_a_round = amount_in_a_round
		self.Pause_betwene = Pause_betwene
		self.units = units

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

var Basic_Bubble = enemys.new("Basic Bubble", 5, 5.0, 1, Vector2(0.3,0.3), 300.0)

var wave=[]

func _ready() -> void:
	get_tree().create_timer(2).timeout.connect(func() -> void: spawn_enemies = false)
	
func spawn_enemy() -> void:
	var enemy = basic_bubble.instantiate()
	add_child(enemy)
	can_spawn = true

func _physics_process(_delta: float) -> void:
	if spawn_enemies and can_spawn:
		can_spawn = false
		get_tree().create_timer(spawn_time_interval).timeout.connect(spawn_enemy)
