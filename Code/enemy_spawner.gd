extends Path2D

@export var spawn_time_interval : float = 0.5

@export var basic_bubble : PackedScene = preload("res://entities/bubble/basic_bubble.tscn")

var spawn_enemies : bool = true
var can_spawn : bool = true

func _ready() -> void:
	get_tree().create_timer(5).timeout.connect(func() -> void: spawn_enemies = false)

func spawn_enemy() -> void:
	var enemy = basic_bubble.instantiate()
	
	add_child(enemy)
	can_spawn = true

#basic spawner for enemy this will need alot of rework later on
func _physics_process(_delta: float) -> void:
	if spawn_enemies and can_spawn:
		can_spawn = false
		get_tree().create_timer(spawn_time_interval).timeout.connect(spawn_enemy)
