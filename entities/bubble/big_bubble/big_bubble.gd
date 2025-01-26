extends PathFollow2D

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $BasicBubble
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

@export var name_enemys: String
@export var speed: float 
var bubble_overflow=200;

@export var enemy_type: String

@export var max_health : float
# @export var freeze_max_health : float = 0
# @export var sheild_max_health : float = 0

@export var base_attack_damage : float = 1
@export var max_size_growth : Vector2

@export var current_health : float
# var current_freez_health : float
# var current_sheild_health : float

#current image scale of bubble
var current_scale : Vector2

var killed : bool = false
func kill() -> void:
	if not killed:
		killed = true
		remove_child(audio_player)
		AudioManager.add_child(audio_player)
		audio_player.play()
		audio_player.finished.connect(audio_player.queue_free)
		call_deferred("queue_free")

func hit_on_caselle(i) -> void:
	find_parent("Node2D").find_child("MainBablue").hit(i)

func update(i) -> void:
	
	var data = get_parent().enemys[1]

	self.speed=data.speed
	self.name_enemys=data.name_enemys
	self.enemy_type=data.enemy_type
	self.max_health=data.max_health
	self.current_health=max_health
	self.base_attack_damage =data.base_damage
	self.max_size_growth =data.max_size_growth
	
	current_scale=current_scale.lerp(max_size_growth, (max_health - current_health)/max_health/10)

func _ready() -> void:
	
	update(1)
	
	if not get_parent() is Path2D:
		kill()

	current_scale = sprite.scale

func _process(delta: float) -> void:
	progress += speed * delta

	if progress_ratio == 1:
		hit_on_caselle(base_attack_damage)
		kill()

func damage(ammount : float, attack_type : GlobalEnums.TowerAttackTypes) -> void:
	match attack_type:
		GlobalEnums.TowerAttackTypes.BUBBLES:
			current_health += ammount
		GlobalEnums.TowerAttackTypes.FIRE:
			current_health -= ammount * 2

	if current_health <= 0 or current_health >= bubble_overflow:
		get_node("../../../Buildings").points += 30
		kill()
	
	anim_player.play("dammage_flash")
	var new_size : Vector2 = current_scale.lerp(max_size_growth, (max_health - current_health)/max_health)
	get_tree().create_tween().set_trans(Tween.TRANS_ELASTIC).tween_property(sprite, "scale", new_size, 0.2)
