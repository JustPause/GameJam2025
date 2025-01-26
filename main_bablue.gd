extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hp():
	return (self.scale.x+self.scale.y/2) / (Vector2(0.1,0.1).x+Vector2(0.1,0.1).y/2)

func hit(i):
	self.scale=Vector2(self.scale.x+ i/100,self.scale.y+i/100)
	
	print(self.scale)
	if self.scale >= Vector2(0.1,0.1):
		print("Boom")
		get_tree().change_scene_to_file("res://Scene/GameOver.tscn")
