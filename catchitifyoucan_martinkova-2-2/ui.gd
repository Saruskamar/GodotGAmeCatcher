extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var lives_label = $LivesLabel
@onready var game_over_label = $GameOverLabel
@onready var restart_button = $RestartButton

func update_score(score: int):
	score_label.text = "Score: %d" % score

func update_lives(lives: int):
	lives_label.text = "Lives: %d" % lives

func show_game_over(score: int):
	game_over_label.text = "GAME OVER\nScore: %d" % score
	game_over_label.visible = true
	restart_button.visible = true

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
