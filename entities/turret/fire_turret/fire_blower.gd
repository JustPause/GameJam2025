extends Node2D

@export var radius : float = 50

@export var damage_rate : float = 1
@export var attack_wait_time : float = 0.25

@export var draw_circle_outline : bool = true :
	set(value):
		draw_circle_outline = value
		queue_redraw()

@onready var enemy_detector : Area2D = $EnemyDetector
@onready var flame : AnimatedSprite2D = $AnimatedSprite2D


var enemies_in_range : Array[HitBox]

var current_target_enemy : HitBox = null
var can_shoot : bool = false

func shoot_timer() -> void:
	get_tree().create_timer(attack_wait_time).timeout.connect(func() -> void: if current_target_enemy: can_shoot = true)

func add_area(area : Area2D) -> void:
	if area is HitBox:
		enemies_in_range.append(area)

		if current_target_enemy == null:
			current_target_enemy = area
			shoot_timer()
		
		#lambda func becaus weird error was occuring when binded to remove area
		area.tree_exiting.connect(remove_area.bind(area))



func remove_area(area : Area2D) -> void:
	enemies_in_range.erase(area)

	if area == current_target_enemy:
		can_shoot = false
		flame.visible = false
		current_target_enemy = null

		var lowest_ratio : float =  1
		for enemy in enemies_in_range:
			if lowest_ratio > enemy.get_parent().progress_ratio:
				lowest_ratio = enemy.get_parent().progress_ratio
				current_target_enemy = enemy

		if current_target_enemy:
			shoot_timer()

func _ready() -> void:
	var collision_shape := CollisionShape2D.new()
	var shape := CircleShape2D.new()
	shape.radius = radius
	collision_shape.shape = shape
	enemy_detector.add_child(collision_shape)

	flame.visible = false

	enemy_detector.area_entered.connect(add_area)
	enemy_detector.area_exited.connect(remove_area)


func _physics_process(_delta: float) -> void:
	if not current_target_enemy:
		return
	
	look_at(current_target_enemy.global_position)

	if not can_shoot:
		return

	flame.visible = true
	current_target_enemy.emit_signal("damage", damage_rate * _delta, GlobalEnums.TowerAttackTypes.FIRE)
	



func _draw() -> void:
	if draw_circle_outline:
		draw_circle(Vector2(), radius, Color.WHITE, false)
