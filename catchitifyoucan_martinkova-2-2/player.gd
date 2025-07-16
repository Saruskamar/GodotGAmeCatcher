extends CharacterBody2D

@export var speed: float = 500.0

func _physics_process(delta):
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = dir * speed
	move_and_slide()

	var screen_width = get_viewport_rect().size.x
	position.x = clamp(position.x, 0, screen_width)
