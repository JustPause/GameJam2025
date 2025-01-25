extends CharacterBody2D

@export var speed = 300

func _process(delta: float) -> void:
	get_parent().set_process(get_parent().get_process_() + speed * delta)
	
func kill() -> void:
	call_deferred("queue_free")
