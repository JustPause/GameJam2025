extends Node2D


export var shoot_cooldown: float = 1.0 # shoot cooldown in seconds

export var bullet_scene: PackedScene # Bullet scene to instance when shooting

export var range: float = 20.0 # range of the turret


var shoot_timer: float = 0.0 # shooting intervals

func _ready():
	shoot_timer = shoot_cooldown

func _process(delta: float):

	shoot_timer -= delta

	var target = find_target()

	if target and shoot_timer <= 0:

		shoot_at_target(target)
		shoot_timer = shoot_cooldown

func find_target() -> Node2D:

	# Get the closest target within range
	var closest_target = null
	var closest_distance = range

	for body in get_tree().get_nodes_in_group("enemies"):

		var distance = global_position.distance_to(body.global_position)

		if distance < closest_distance:
			closest_target = body
			closest_distance = distance

	return closest_target

func shoot_at_target(target: Node2D):

	if bullet_scene:

		var bullet = bullet_scene.instance()
		get_parent().add_child(bullet)

		bullet.global_position = global_position
		bullet.look_at(target.global_position)
		bullet.set_target(target)

		print("Shot fired at %s" % target.name)
