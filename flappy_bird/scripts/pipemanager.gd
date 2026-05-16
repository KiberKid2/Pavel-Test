extends Node2D

@export var scroll_speed: float = 200.0
@export var spawn_interval: float = 1.5

var pipe_scene: PackedScene
var spawn_timer: float = 0.0
var game_over: bool = false

signal score_changed(score: int)
signal game_ended

var current_score: int = 0


func _ready() -> void:
	pipe_scene = preload("res://scenes/pipe.tscn")


func _process(delta: float) -> void:
	if game_over:
		return
	
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_pipe()
	
	move_pipes(delta)


func spawn_pipe() -> void:
	var pipe = pipe_scene.instantiate()
	add_child(pipe)
	
	var viewport_height = get_viewport_rect().size.y
	var gap_position = randf_range(150, viewport_height - 150)
	pipe.position = Vector2(get_viewport_rect().size.x + 50, gap_position)


func move_pipes(delta: float) -> void:
	for child in get_children():
		if child is Node2D and child.has_method("move"):
			child.move(delta * scroll_speed)
			if child.position.x < -100:
				child.queue_free()


func add_score() -> void:
	current_score += 1
	score_changed.emit(current_score)


func end_game() -> void:
	game_over = true
	game_ended.emit()


func reset_game() -> void:
	for child in get_children():
		if child is Node2D and child.has_method("queue_free"):
			child.queue_free()
	current_score = 0
	spawn_timer = 0.0
	game_over = false
	score_changed.emit(0)
