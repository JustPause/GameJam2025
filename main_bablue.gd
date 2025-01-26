extends Node2D
var hp_:float

func _ready() -> void:
	hp_ = 100

func hp():
	return hp_/10

func hit(i):
	hp_-=i*10
	scale = Vector2.ZERO.lerp(Vector2(.1,.1), (100-hp_)/hp_)
	
	print(hp_)
	if hp_<=0:
		get_tree().change_scene_to_file("res://Scene/GameOver.tscn")
