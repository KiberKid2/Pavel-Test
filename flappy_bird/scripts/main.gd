extends Node2D

@onready var bird: CharacterBody2D = $Bird
@onready var pipe_manager: Node2D = $PipeManager
@onready var ui: CanvasLayer = $UI
@onready var ground: StaticBody2D = $Ground

var game_started: bool = false


func _ready() -> void:
	pipe_manager.score_changed.connect(ui.update_score)
	pipe_manager.game_ended.connect(_on_game_over)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if not game_started:
			game_started = true
		elif pipe_manager.game_over:
			pass


func _process(_delta: float) -> void:
	if game_started and not pipe_manager.game_over:
		check_score()


func check_score() -> void:
	for child in pipe_manager.get_children():
		if child.has_method("check_score"):
			if child.check_score(bird.position.x):
				pipe_manager.add_score()


func _on_game_over() -> void:
	bird.die()
	ui.show_game_over()


func _on_bird_died() -> void:
	pipe_manager.end_game()
