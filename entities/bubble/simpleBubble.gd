extends PathFollow2D

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $BasicBubble

@export var speed: float = 300.0 #px/s

@export var max_health : int  = 5
@export var base_damage : int = 1
@export var max_size_growth : Vector2 = Vector2(0.3,0.3)

var current_health : int
#current image scale of bubble
var current_scale : Vector2


func kill() -> void:
	call_deferred("queue_free")


func _ready() -> void:
	#check is its parent is a path2d
	if not get_parent() is Path2D:
		kill()
	
	current_health = max_health
	current_scale = sprite.scale


#moves the bubble along the path and when reaches end is killed
func _process(delta: float) -> void:
	progress += speed * delta

	if progress_ratio == 1:
		kill()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			damage(1)

func damage(ammount : int) -> void:
	#applies dammage and kills bubble if health == 0
	current_health -= ammount
	if current_health <= 0:
		kill()
	
	#plays a red sprite flash
	anim_player.play("dammage_flash")
	
	#grows the size of the bubble
	var new_size : Vector2 = current_scale.lerp(max_size_growth, (max_health - current_health)/float(max_health))
	get_tree().create_tween().set_trans(Tween.TRANS_ELASTIC).tween_property(sprite, "scale", new_size, 0.2)
