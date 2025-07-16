
extends Node2D

@export var good_item_scene: PackedScene
@export var bad_item_scene: PackedScene

var score_label
var lives_label
var restart_button
var game_over_ui

var score = 0
var lives = 3
var spawn_timer = 0.0
var spawn_interval = 2.0
var min_interval = 0.5
var speed_up = 0.005
var game_over = false
var paused = false

func _ready():
	score_label = $ScoreLabel
	lives_label = $LivesLabel
	restart_button = $Restart
	game_over_ui = $GameOver

	_update_ui()
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)
	set_process(true)

func _process(delta):
	if paused or game_over:
		return

	spawn_timer -= delta
	if spawn_timer <= 0.0:
		spawn_timer = spawn_interval
		spawn_interval = max(min_interval, spawn_interval - spawn_interval * speed_up)
		_spawn_item()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and not game_over:
		paused = not paused

func _spawn_item():
	if not good_item_scene or not bad_item_scene:
		return
	var scene = good_item_scene if randf() < 0.5 else bad_item_scene
	var item = scene.instantiate()
	var screen_width = get_viewport_rect().size.x
	item.position = Vector2(randi_range(0, screen_width), -20)
	add_child(item)

func on_good_item_caught():
	score += 10
	_update_ui()

func on_good_item_missed():
	score -= 2
	_update_ui()

func on_bad_item_caught():
	lives -= 1
	_update_ui()
	if lives <= 0:
		_game_over()

func _game_over():
	game_over = true
	if game_over_ui:
		game_over_ui.visible = true

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _update_ui():
	if score_label:
		score_label.text = "Score: %d" % score
	if lives_label:
		lives_label.text = "Lives: %d" % lives
