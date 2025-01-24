extends PathFollow2D

@export var speed: float = 300.0 #px/s

func _ready() -> void:
	#check is its parent is a path2d
	if not get_parent() is Path2D:
		queue_free()

func _process(delta: float) -> void:
	progress += speed * delta

	#when it reaches the end we wil emmit a signal to dammage the tower and do some other stuff
	if progress_ratio == 1:
		queue_free()
