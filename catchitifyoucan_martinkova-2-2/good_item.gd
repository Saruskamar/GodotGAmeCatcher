extends Area2D

@export var speed: float = 200.0
signal caught(is_good: bool)

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y:
		queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("caught", true)
		queue_free()
