extends Area2D

# Called when a physics body enters this Area2D
func _on_Area2D_body_entered(body: Node) -> void:
	print("Collision detected!")
	print("Collided with:", body.name)
	if body.has_method("get_position"):
		print("Collided object's position:", body.get_position())
