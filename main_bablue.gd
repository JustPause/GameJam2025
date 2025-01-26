extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func hit():
	self.scale=Vector2(self.scale.x+ 0.01,self.scale.y+ 0.01)
	
	print(self.scale)
	if self.scale >= Vector2(0.1,0.1):
		print("Boom")
		get_tree().change_scene_to_file("res://Scene/GameOver.tscn")
