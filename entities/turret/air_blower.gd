extends Node2D

@export var radius : float = 75
@export var damage : int = 1
@export var attack_speed : float = 0.4
@export var draw_circle_outline : bool = true


@onready var enemy_detector : Area2D = $EnemyDetector

var enemies_in_range : Array[HitBox]
var can_shoot : bool = true :
	set(value):
		can_shoot = value
		queue_redraw()


func add_area(area : Area2D) -> void:
	if area is HitBox:
		enemies_in_range.append(area)

		#lambda func becaus weird error was occuring when binded to remove area
		area.tree_exiting.connect(func() -> void: enemies_in_range.erase(area))

func remove_area(area : Area2D) -> void:
	enemies_in_range.erase(area)

func shoot() -> void:
	can_shoot = false
	get_tree().create_timer(attack_speed).timeout.connect(func() -> void: can_shoot = true)
	
	enemies_in_range[0].emit_signal("damage", damage)

func _ready() -> void:
	var collision_shape := CollisionShape2D.new()
	var shape := CircleShape2D.new()
	shape.radius = radius
	collision_shape.shape = shape
	enemy_detector.add_child(collision_shape)

	enemy_detector.area_entered.connect(add_area)
	enemy_detector.area_exited.connect(remove_area)


func _physics_process(_delta: float) -> void:
	if can_shoot and enemies_in_range.size() > 0:
		shoot()

func _draw() -> void:
	if draw_circle_outline:
		draw_circle(Vector2(), radius, Color.WHITE, false)