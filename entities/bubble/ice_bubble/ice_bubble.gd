extends PathFollow2D

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $BasicBubble
@onready var freezeSprite : Sprite2D = $BasicBubble2
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer


@export var speed: float = 300.0 #px/s

var bubble_overflow=200;
@export var bubble_max_health : float  = 100
@export var freeze_max_health : float = 200
# @export var sheild_max_health : float = 0

@export var base_attack_damage : float = 2
@export var max_size_growth : Vector2 = Vector2(0.3,0.3)

var current_bubble_health : float
var current_freeze_health : float
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
	

func _ready() -> void:
	if not get_parent() is Path2D:
		kill()
	
	current_bubble_health = bubble_max_health
	current_freeze_health = freeze_max_health
	current_scale = sprite.scale

func _process(delta: float) -> void:
	progress += speed * delta

	if progress_ratio == 1:
		hit_on_caselle(2)
		kill()

func damage(ammount : float, attack_type : GlobalEnums.TowerAttackTypes) -> void:
	match attack_type:
		GlobalEnums.TowerAttackTypes.BUBBLES:
			if current_freeze_health > 0:
				current_freeze_health -= ammount * 0.5
			else:
				current_bubble_health += ammount
			
		GlobalEnums.TowerAttackTypes.FIRE:
			if current_freeze_health > 0:
				current_freeze_health -= ammount 
			else:
				current_bubble_health -= ammount * 2

	anim_player.play("dammage_flash")

	if current_freeze_health <= 0:
		freezeSprite.visible = false
		sprite.visible = true

		var new_size : Vector2 = current_scale.lerp(max_size_growth, (bubble_max_health - current_bubble_health)/bubble_max_health)
		get_tree().create_tween().set_trans(Tween.TRANS_ELASTIC).tween_property(sprite, "scale", new_size, 0.2)

	if current_bubble_health <= 0 or current_bubble_health >= bubble_overflow:
		get_node("../../../Buildings").points += 50
		kill()
