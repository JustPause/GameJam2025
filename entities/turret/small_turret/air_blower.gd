extends Node2D

@export var radius : float = 75
@export var damage : float = 1
@export var attack_speed : float = 0.4
var price =100

@export var draw_circle_outline : bool = true:
	set(value):
		can_shoot = value
		queue_redraw()

@onready var enemy_detector : Area2D = $EnemyDetector
@onready var particles : CPUParticles2D = $GPUParticles2D
@onready var shoot_sound : AudioStreamPlayer = $AudioStreamPlayer

var enemies_in_range : Array[HitBox]
var can_shoot : bool = true
var current_target_enemy : HitBox = null

func pay():
	return price

func add_area(area : Area2D) -> void:
	if area is HitBox:
		enemies_in_range.append(area)

		if not current_target_enemy:
			current_target_enemy = area

		#lambda func becaus weird error was occuring when binded to remove area
		area.tree_exiting.connect(func() -> void: enemies_in_range.erase(area))

func remove_area(area : Area2D) -> void:
	enemies_in_range.erase(area)

	if area == current_target_enemy:
		current_target_enemy = null

func shoot() -> void:
	can_shoot = false
	get_tree().create_timer(attack_speed).timeout.connect(func() -> void: can_shoot = true)

	#findes the node wich is the furtherest into the tree
	var highest_ratio : float =  0
	for enemy in enemies_in_range:
		if highest_ratio < enemy.get_parent().progress_ratio:
			highest_ratio = enemy.get_parent().progress_ratio
			current_target_enemy = enemy

	particles.emitting = true
	shoot_sound.play()
	current_target_enemy.emit_signal("damage", damage, GlobalEnums.TowerAttackTypes.BUBBLES)

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
	
	if current_target_enemy:
		look_at(current_target_enemy.global_position)


func _draw() -> void:
	if draw_circle_outline:
		draw_circle(Vector2(), radius, Color.WHITE, false)
