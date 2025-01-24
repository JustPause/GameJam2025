extends CharacterBody2D


@export var speed: float = 300.0

# Target where the bullet moves
var target: Node2D = null

func set_target(new_target: Node2D):
	target = new_target

func _process(delta: float):

	if target and target.is_instance_valid():

		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

		# Check if bullet reached target

		if global_position.distance_to(target.global_position) < 10:
			print("Hit target: %s" % target.name)

			target.queue_free()  # Destroy target

			queue_free()  # Destroy bullet


	else:
		queue_free()  # Destroy bullet if no target
