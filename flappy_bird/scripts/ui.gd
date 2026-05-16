extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var game_over_panel: Panel = $GameOverPanel
@onready var final_score_label: Label = $GameOverPanel/VBoxContainer/FinalScoreLabel
@onready var restart_button: Button = $GameOverPanel/VBoxContainer/RestartButton

var current_score: int = 0


func _ready() -> void:
	game_over_panel.visible = false
	restart_button.pressed.connect(_on_restart_pressed)


func update_score(score: int) -> void:
	current_score = score
	score_label.text = str(score)


func show_game_over() -> void:
	final_score_label.text = "Score: " + str(current_score)
	game_over_panel.visible = true


func hide_game_over() -> void:
	game_over_panel.visible = false


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
