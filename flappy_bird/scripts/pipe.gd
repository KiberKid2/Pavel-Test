extends Node2D

@export var speed: float = 200.0
@export var gap_size: float = 170.0

var passed_score: bool = false

@onready var top_pipe: Sprite2D = $TopPipe
@onready var bottom_pipe: Sprite2D = $BottomPipe
@onready var top_collision: StaticBody2D = $TopPipe/CollisionShape2D
@onready var bottom_collision: StaticBody2D = $BottomPipe/CollisionShape2D


func _ready() -> void:
	update_pipe_positions()


func move(delta_speed: float) -> void:
	position.x -= delta_speed


func update_pipe_positions() -> void:
	var viewport_height = get_viewport_rect().size.y
	
	top_pipe.position = Vector2(0, -viewport_height)
	bottom_pipe.position = Vector2(0, viewport_height)
	
	update_collision_shapes(viewport_height)


func update_collision_shapes(viewport_height: float) -> void:
	var pipe_width = 60.0
	var pipe_height = viewport_height
	
	if top_collision and top_collision.shape:
		top_collision.shape.size = Vector2(pipe_width, pipe_height)
		top_collision.position = Vector2(0, -viewport_height / 2 + gap_size / 2)
	
	if bottom_collision and bottom_collision.shape:
		bottom_collision.shape.size = Vector2(pipe_width, pipe_height)
		bottom_collision.position = Vector2(0, viewport_height / 2 + gap_size / 2)


func check_score(bird_x_position: float) -> bool:
	if not passed_score and bird_x_position > position.x:
		passed_score = true
		return true
	return false
